# 🌿 Ayda AI — Caregiver Health Assistant

Ayda is an **AI-powered caregiver assistant** that helps families understand complex medical documents in clear, compassionate language.  
It’s designed to **reduce anxiety**, **save time**, and **bridge communication** between patients, families, and clinicians — safely and ethically.

---

## 🚀 MVP Overview

Ayda’s MVP converts uploaded **medical records (PDFs or images)** into structured, plain-language summaries with:

- ✅ Simple explanations
- 🚨 Gentle alerts for possible urgent topics
- 🌍 Bilingual support (English + Spanish)
- 📁 History & feedback system

All data is securely stored using Firebase and processed with HIPAA-aligned safeguards.

---

## 🧠 Tech Stack

| Layer              | Technology                                                 |
| ------------------ | ---------------------------------------------------------- |
| **Frontend**       | Flutter 3 (Web & Desktop), Material 3, Riverpod, go_router |
| **Backend**        | Firebase (Auth, Firestore, Storage, Functions)             |
| **AI Integration** | OpenAI GPT-4.1-mini via callable Cloud Function            |
| **Infra / CI/CD**  | GitHub Actions + Firebase Hosting                          |
| **Design**         | Custom Ayda color system + Google Fonts (Inter, DM Sans)   |

---

## 🎨 Brand System

**Core Colors**
| Role | Name | HEX |
|------|------|------|
| Primary | Serenity Indigo | `#3A60C0` |
| Secondary | Healing Sage | `#6BB89D` |
| Accent | Coral Care | `#FF857A` |
| Background | Linen White | `#F9F9F6` |
| Text | Midnight Slate | `#2D3748` |

**Typography**

- Headings: _Inter SemiBold (24–20px)_
- Body: _Inter Regular (16px)_
- Display: _DM Sans Bold (32px)_

See [`brand/ayda_palette.json`](brand/ayda_palette.json) for JSON color tokens.

---

## ⚙️ Project Structure

Suggested top-level layout:

- `frontend/` — Flutter app (web & desktop targets)
- `functions/` — Firebase Cloud Functions (AI integration, document processing)
- `brand/` — Design tokens, palettes, and assets (contains `ayda_palette.json`)
- `docs/` — Product docs, architecture notes, and security/HIPAA guidance
- `infra/` — CI/CD configs, Firebase hosting configuration, GitHub Actions

If you want I can also add a quick "How to run locally" section or generate skeleton files for these folders.
