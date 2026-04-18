# Spec Document Reviewer Prompt Template

Use this template when dispatching a spec-document-reviewer subagent after writing `design.md`.

**Purpose:** Verify the design document is complete, consistent, and ready to be formalized into a spec by `sdd-superpowers:sdd-specify`.

**Dispatch after:** Design document is written to `docs/specs/NNN-<feature-slug>/design.md`

```
Task tool (general-purpose):
  description: "Review SDD design document"
  prompt: |
    You are a spec document reviewer for an SDD (Specification-Driven Development) project.
    Verify this design document is complete and ready to be passed to sdd-specify for formalization.

    **Design doc to review:** [DESIGN_FILE_PATH]

    ## What to Check

    | Category | What to Look For |
    |----------|-----------------|
    | Completeness | TODOs, placeholders, "TBD", empty sections, missing required sections |
    | Consistency | Internal contradictions, conflicting decisions |
    | Clarity | Statements ambiguous enough to cause sdd-specify to ask clarifying questions |
    | Scope | Single coherent feature — not spanning multiple independent subsystems |
    | YAGNI | Unrequested features, over-engineering, "might need later" additions |
    | Approach | Is the chosen approach concrete enough to plan from? Or still vague? |

    ## Required Sections

    The design doc must contain ALL of these sections with non-empty content:
    - Problem
    - Chosen Approach
    - Trade-offs & Rationale
    - Key Design Decisions
    - Out of Scope

    ## Calibration

    **Only flag issues that would cause real problems when sdd-specify tries to formalize this into a spec.**
    A missing section, a contradiction, an approach so vague that sdd-specify would need to re-ask the
    same questions we already answered in brainstorming — those are issues.

    Minor wording improvements, stylistic preferences, and "could be more detailed" are not issues.

    Approve unless there are serious gaps.

    ## Output Format

    ## Design Review

    **Status:** Approved | Issues Found

    **Issues (if any):**
    - [Section]: [specific issue] — [why it matters for sdd-specify formalization]

    **Recommendations (advisory, do not block approval):**
    - [suggestions for improvement]
```

**Reviewer returns:** Status, Issues (if any), Recommendations
