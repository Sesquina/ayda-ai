# Ayda AI — Validation & User Testing Plan

Version 1.0 · November 2025

---

### 1️⃣ Objective

Validate Ayda’s ability to improve **comprehension, confidence, and care coordination** among caregivers and patients reviewing medical records.

The plan measures *clinical literacy outcomes* and *usability metrics* across diverse users while ensuring full ethical and IRB compliance.

---

### 2️⃣ Study Design

| Parameter      | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| **Design**     | Mixed-methods: pre/post comprehension tests + in-app feedback  |
| **Population** | 60 caregivers (bilingual cohort: 30 English / 30 Spanish)      |
| **Setting**    | Remote, virtual testing via HIPAA-secure Ayda app              |
| **Duration**   | 4 weeks per cohort                                             |
| **Goal**       | Quantify comprehension gain, stress reduction, and trust score |

---

### 3️⃣ Methods

#### a. Quantitative Metrics

1. **Comprehension Accuracy (%)** — pre/post-test based on mock discharge summaries.
2. **Reading Time (seconds)** — average time per summary.
3. **Red Flag Recognition (%)** — % of users correctly identifying urgent issues.
4. **Feedback Sentiment (👍 / 👎 ratio)** — real-time satisfaction indicator.
5. **COMPREHENSION_SCORE Δ (Firestore metric)** — automatic internal scoring trend.

#### b. Qualitative Metrics

1. **Emotional Tone Feedback** — 1–5 scale (“Calm,” “Overwhelming,” etc.)
2. **Trust in Summary (Likert 1–5)** — “I feel confident explaining this to my doctor.”
3. **Ease of Use (SUS score)** — System Usability Scale administered at end of week 4.

---

### 4️⃣ Data Collection & Analysis

* **Firestore metrics:** auto-logged by Ayda backend.
* **Survey responses:** stored securely in `/feedback` collection.
* **Analysis tool:** exported to Python notebook for paired t-tests + effect size.
* **Target effect size:** *Cohen’s d ≥ 0.6* (moderate–strong comprehension improvement).

---

### 5️⃣ Ethical Oversight

* De-identification pipeline enforced before AI access.
* No PHI retained post-summary.
* IRB consultation planned via NIH Applicant Assistance Program (AAP).
* Consent form stored as digital acknowledgment within app.
* Participants can delete data any time (GDPR-compliant logic).

---

### 6️⃣ Success Criteria (for SBIR Phase I)

| Metric              | Threshold | Interpretation                          |
| ------------------- | --------- | --------------------------------------- |
| Avg Comprehension ↑ | ≥ +30 %   | Statistically significant literacy gain |
| Red Flags ↓         | ≥ -40 %   | Earlier recognition of urgent issues    |
| SUS Score           | ≥ 80/100  | “Excellent” usability                   |
| Trust Score         | ≥ 4.0/5   | Emotional validation                    |
| Attrition           | ≤ 15 %    | Strong engagement                       |

---

### 7️⃣ Deliverables

* **Validation Summary Report (PDF)** — for SBIR Phase II submission
* **Poster-ready visualizations** — comprehension and stress metrics
* **IRB statement of compliance** — included in Phase I completion packet

---

## ✅ Next Action

After MVP deployment, recruit 10 pilot users from bilingual caregiving networks (e.g., Latino Cancer Institute, CaringBridge).
Run the 4-week pilot → export anonymized results → attach to grant report.
