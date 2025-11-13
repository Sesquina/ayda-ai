import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/ayda_primary_button.dart';
import '../data/upload_repository.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  static const routeName = '/upload';

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _tagsController = TextEditingController();
  final _repository = UploadRepository();
  bool _isUploading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _simulateUpload() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _errorMessage = 'Sign in to upload a caregiver note.';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
      _isUploading = true;
    });

    final fileName = _titleController.text.trim();
    final notes = _notesController.text.trim();
    final tags = _parseTags(_tagsController.text);
    final sanitizedName = fileName
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp('-{2,}'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    final storagePath =
        'uploads/${user.uid}/${DateTime.now().millisecondsSinceEpoch}-$sanitizedName.txt';

    try {
      final record = await _repository.createUploadRecord(
        ownerId: user.uid,
        fileName: fileName,
        storagePath: storagePath,
        notes: notes.isEmpty ? null : notes,
        tags: tags,
      );

      if (!mounted) return;
      _titleController.clear();
      _notesController.clear();
      _tagsController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Metadata created for ${record.fileName}.'),
        ),
      );
      context.push('/summary/${record.id}');
    } on FirebaseException catch (error) {
      setState(() {
        _errorMessage = error.message ?? 'Unable to save upload metadata.';
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Unexpected error: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  List<String> _parseTags(String raw) {
    final tokens = raw
        .split(',')
        .map((token) => token.trim())
        .where((token) => token.isNotEmpty)
        .toList();
    return tokens;
  }

  String? _validateFileName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a file name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload care notes'),
        actions: [
          if (user != null)
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout),
              tooltip: 'Sign out',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user != null) ...[
                Text(
                  'Signed in as ${user.email ?? user.uid}',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
              ],
              Text(
                'Create upload metadata in Firestore. Connect Firebase Storage next to attach real files.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'File name',
                            hintText: 'e.g. Evening shift notes',
                          ),
                          validator: _validateFileName,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            labelText: 'Care notes (optional)',
                          ),
                          minLines: 3,
                          maxLines: 5,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _tagsController,
                          decoration: const InputDecoration(
                            labelText: 'Tags',
                            helperText: 'Comma separated keywords to help summarization',
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        AydaPrimaryButton(
                          label: 'Save metadata and simulate upload',
                          icon: Icons.upload_rounded,
                          onPressed: _simulateUpload,
                          isLoading: _isUploading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
