# SDD Research: Full Process Reference

> Complete investigation procedure, research.md template, and quality standards. See [SKILL.md](SKILL.md) for the summary.

## Step 1: Load the Spec

Read `docs/specs/<NNN>-<feature-slug>/spec.md`. Identify:
- Open questions that require technical investigation
- Non-functional requirements (performance, security, reliability) that need validation
- Technology dependencies implied by the requirements
- Any `[NEEDS CLARIFICATION]` markers that research can resolve

## Step 2: Define Research Questions

Before investigating, list the specific questions you will answer. Present these to the user:

> "I'll research these questions before planning:
> 1. <Specific question>
> 2. <Specific question>
> 
> Any additional questions you want investigated?"

## Step 3: Investigate

For each research question, investigate thoroughly:

**Library/framework comparisons:**
- List top 2-4 candidates with their trade-offs
- Note: license, maturity, maintenance status, community size
- Note: specific compatibility with the project's existing stack
- Note: performance benchmarks if available
- Make a clear recommendation with rationale

**Performance analysis:**
- Identify the performance-critical path for the feature
- Estimate load characteristics (requests/sec, data volume, concurrency)
- Identify potential bottlenecks before they become problems
- Recommend caching, indexing, or architectural patterns if needed

**Security review:**
- Identify threat vectors relevant to this feature
- Check OWASP guidance for the feature type
- Note authentication/authorization requirements
- Flag data sensitivity and relevant compliance requirements (GDPR, HIPAA, etc.)

**Integration research:**
- Document the external API's constraints (rate limits, auth, data formats)
- Note failure modes and how to handle them
- Identify if SDK exists vs raw HTTP needed

## Step 4: Write Research Document

Generate `docs/specs/<NNN>-<feature-slug>/research.md`:

```markdown
# Research: <Feature Name>

**Feature:** docs/specs/<NNN>-<feature-slug>/spec.md
**Date:** YYYY-MM-DD

---

## Summary of Findings

<3-5 bullet points of the most important findings that will affect implementation decisions.>

---

## Question 1: <Research Question>

### Context
<Why this question matters for implementation.>

### Findings

#### Option A: <Name>
**Pros:** <list>
**Cons:** <list>
**Best for:** <use case>

#### Option B: <Name>
**Pros:** <list>
**Cons:** <list>
**Best for:** <use case>

### Recommendation
**Use <Option X>** because <specific rationale tied to spec requirements>.

---

## Question 2: <Research Question>
...

---

## Resolved Clarifications

Items from the spec's `[NEEDS CLARIFICATION]` list that research has resolved:

| Question | Resolution | Source |
|----------|------------|--------|
| <Original question> | <Answer> | <Evidence> |

---

## Remaining Open Questions

Items that require product/business decisions (cannot be resolved by research alone):

- [DECISION NEEDED: <question for the human>]

---

## Constraints Discovered

Technical or organizational constraints that MUST be respected in the implementation plan:

- <Constraint and its source>
- <Constraint and its source>
```

## Step 5: Update the Spec

If research resolves `[NEEDS CLARIFICATION]` items in the spec:
1. Open `docs/specs/<NNN>-<feature-slug>/spec.md`
2. Replace the clarification markers with concrete requirements
3. Note in the spec: `*Updated based on research findings YYYY-MM-DD*`

## Step 6: Verify Before Claiming Complete

Before reporting research as done, confirm:
- [ ] Every `[NEEDS CLARIFICATION]` from the spec is either resolved or escalated to `[DECISION NEEDED]`
- [ ] Every research question from Step 2 has a documented answer with evidence
- [ ] Recommendations cite specific sources, not just opinions

**Do not say "research complete" without running this checklist.**

## Step 7: Handoff

Present a summary of key findings and decisions made:

> "Research complete — saved to `docs/specs/NNN-feature-slug/research.md`.
>
> **Key decisions:** <3-4 bullet points of the most important choices>
>
> **Remaining questions needing your input:** <list any DECISION NEEDED items>
>
> Ready to proceed with `sdd-plan`."

## Research Quality Standards

**Cite evidence:** Every recommendation must have a specific rationale. "It's popular" is not sufficient. "It has native TypeScript support and we're already using it for X" is sufficient.

**Acknowledge uncertainty:** If you cannot find reliable benchmark data, say so. "No performance data found; recommend load testing after implementation."

**Stay grounded in the spec:** Research should answer questions the spec raises. Don't investigate hypothetical future requirements.

**Avoid analysis paralysis:** Pick a clear recommendation for each question. List trade-offs but commit to a direction.
