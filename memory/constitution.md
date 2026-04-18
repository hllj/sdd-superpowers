# Project Constitution

> These principles are immutable. Every implementation plan must pass gates derived from them.
> To amend, follow Section 4.2.

---

## Article I: Library-First Principle

Every skill in this project MUST be a self-contained, independently invocable unit. No functionality shall be embedded only within another skill's flow without first being abstracted into its own named skill with clear intent boundaries and minimal dependencies on other skills.

---

## Article II: CLI Interface Mandate

All skills MUST declare their trigger condition, inputs, and expected outputs in a structured `SKILL.md` header so they are inspectable and auditable without execution.

---

## Article III: Test-First Imperative

This is NON-NEGOTIABLE: All skill creation and modification MUST follow a verification-first approach. No skill content shall be written before: (1) the trigger condition and success criteria are defined, (2) a quickstart or smoke-test scenario exists, (3) the skill has been validated against at least one real use case. Every skill change must be traceable to a spec requirement.

---

## Article IV: Writing-Skills Compliance

All new skills MUST follow the structured best practices defined in the `sdd-superpowers:writing-skills` meta skill. Before creating any new skill, invoke `writing-skills` and follow its instructions exactly.

---

## Article V: Feedback-Driven Spec Updates

Failed skill invocations must update the relevant spec before a fix is planned, and only when the user explicitly mentions the failure.

---

## Article VI: Spec Review Gate

Always ask the user to review and approve the spec before any planning, task generation, or implementation begins. No downstream step proceeds without explicit user approval.

---

## Article VII: Simplicity Gate

Maximum 3 major sections for any initial skill implementation. No future-proofing — build only what the current spec requires. Any additional complexity (new sections, sub-skills, reference files) requires documented justification in the plan. Adding a new skill dependency requires explicit rationale tied to a spec requirement.

---

## Article VIII: Anti-Abstraction Gate

Use direct skill invocation rather than wrapping skills inside other skills unnecessarily. Maintain a single, canonical flow per skill — no parallel or redundant instruction chains. Every reference file, sub-skill, or helper must be justified by a concrete spec requirement, not anticipated future need.

---

## Article IX: Integration-First Testing

Skills MUST be validated against real invocation scenarios before being marked complete. Prefer testing with actual user requests over synthetic examples. Smoke-test scenarios in `quickstart.md` are mandatory before any skill is considered done. Do not mark a skill complete based on reading alone — it must be invoked and observed.

---

## Section 4.2: Amendment Process

Modifications to this constitution require:
- Explicit documentation of the rationale for change
- Review and approval by project maintainers
- Backwards compatibility assessment
