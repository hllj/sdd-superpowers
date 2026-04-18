# Systematic Debugging: Full Procedure Reference

## The Four Phases (Detail)

You MUST complete each phase before proceeding to the next.

### Phase 1: Root Cause Investigation

**BEFORE attempting ANY fix:**

1. **Read Error Messages Carefully** — Don't skip past errors or warnings. Read stack traces completely. Note line numbers, file paths, error codes.

2. **Reproduce Consistently** — Can you trigger it reliably? What are the exact steps? If not reproducible → gather more data, don't guess.

3. **Check Recent Changes** — What changed that could cause this? Git diff, recent commits, new dependencies, config changes, environmental differences.

4. **Gather Evidence in Multi-Component Systems**

   **WHEN system has multiple components (CI → build → signing, API → service → database):**

   **BEFORE proposing fixes, add diagnostic instrumentation:**
   ```
   For EACH component boundary:
     - Log what data enters component
     - Log what data exits component
     - Verify environment/config propagation
     - Check state at each layer

   Run once to gather evidence showing WHERE it breaks
   THEN analyze evidence to identify failing component
   THEN investigate that specific component
   ```

   **Example:**
   ```bash
   # Layer 1: Workflow
   echo "IDENTITY: ${IDENTITY:+SET}${IDENTITY:-UNSET}"
   # Layer 2: Build script
   env | grep IDENTITY || echo "IDENTITY not in environment"
   # Layer 3: Signing script
   security list-keychains && security find-identity -v
   # Layer 4: Actual signing
   codesign --sign "$IDENTITY" --verbose=4 "$APP"
   ```

5. **Trace Data Flow** — See `root-cause-tracing.md` for the complete backward tracing technique. Quick version: where does bad value originate? What called this with bad value? Keep tracing up until you find the source. Fix at source, not at symptom.

### Phase 2: Pattern Analysis

1. **Find Working Examples** — Locate similar working code in same codebase.
2. **Compare Against References** — If implementing a pattern, read the reference implementation COMPLETELY — don't skim.
3. **Identify Differences** — List every difference between working and broken, however small.
4. **Understand Dependencies** — What other components, settings, config, environment does this need?

### Phase 3: Hypothesis and Testing

1. **Form Single Hypothesis** — State clearly: "I think X is the root cause because Y." Write it down. Be specific.
2. **Test Minimally** — Make the SMALLEST possible change to test hypothesis. One variable at a time.
3. **Verify Before Continuing** — Worked? → Phase 4. Didn't work? → Form NEW hypothesis. Don't add more fixes on top.
4. **When You Don't Know** — Say "I don't understand X." Don't pretend. Ask for help. Research more.

### Phase 4: Implementation

1. **Create Failing Test Case** — Simplest possible reproduction. Use `test-driven-development` for writing proper failing tests.
2. **Implement Single Fix** — Address root cause. ONE change at a time. No "while I'm here" improvements.
3. **Verify Fix** — Test passes? No other tests broken? Issue resolved?
4. **If Fix Doesn't Work** — STOP. Count fixes tried. If < 3: return to Phase 1. **If ≥ 3: question the architecture.**

### If 3+ Fixes Failed: Question Architecture

Pattern indicating architectural problem:
- Each fix reveals new shared state/coupling/problem in different place
- Fixes require massive refactoring
- Each fix creates new symptoms elsewhere

STOP and discuss with your human partner before attempting more fixes. This is NOT a failed hypothesis — this is a wrong architecture.

## Red Flags — STOP and Follow Process

If you catch yourself thinking:
- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "It's probably X, let me fix that"
- "I don't fully understand but this might work"
- "Pattern says X but I'll adapt it differently"
- "Here are the main problems: [lists fixes without investigation]"
- Proposing solutions before tracing data flow
- "One more fix attempt" (when already tried 2+)
- Each fix reveals a new problem in a different place

**ALL of these mean: STOP. Return to Phase 1.**

## Human Partner Signals You're Doing It Wrong

- "Is that not happening?" — You assumed without verifying
- "Will it show us...?" — You should have added evidence gathering
- "Stop guessing" — You're proposing fixes without understanding
- "Ultrathink this" — Question fundamentals, not just symptoms
- "We're stuck?" (frustrated) — Your approach isn't working

**When you see these:** STOP. Return to Phase 1.

## When Process Reveals "No Root Cause"

If systematic investigation reveals issue is truly environmental, timing-dependent, or external:
1. You've completed the process
2. Document what you investigated
3. Implement appropriate handling (retry, timeout, error message)
4. Add monitoring/logging for future investigation

**But:** 95% of "no root cause" cases are incomplete investigation.

## Supporting Techniques

- **`root-cause-tracing.md`** — Trace bugs backward through call stack to find original trigger
- **`defense-in-depth.md`** — Add validation at multiple layers after finding root cause
- **`condition-based-waiting.md`** — Replace arbitrary timeouts with condition polling

## Real-World Impact

- Systematic approach: 15–30 minutes to fix
- Random fixes approach: 2–3 hours of thrashing
- First-time fix rate: 95% vs 40%
- New bugs introduced: near zero vs common
