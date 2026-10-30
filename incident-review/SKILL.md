---
name: incident-review
description: Reconstruct what happened during a reported incident as a short timestamped brief built from real UGREEN NAS surveillance events and evidence. Use when the user asks what happened in a room or at a camera during a time window, or asks to review or summarize monitoring events involving people, vehicles, pets, or packages.
---

# Goal

Turn a fuzzy report into a short incident brief that reconstructs the sequence of real events for one location and time window, using only events and evidence the UGREEN NAS actually recorded. The brief orders the candidate events, labels each person or vehicle as familiar or unknown where the NAS can decide, and adds a plain-language narrative summary.

The Skill narrows a rough report into a reviewable timeline. It does not name a specific person unless the NAS already recognizes that person, and it never invents events, identities, or evidence.

Scope: incidents inside the surveillance retention window, on cameras the NAS already manages.

# Required input

Gather only what the workflow needs:

- Location: a room, floor, or camera the user can name.
- Time window: a start and end time, however rough; if the report spans longer than the NAS retention window, agree a narrower window with the user first.
- Optional focus: the event kind to look for, such as a person, face, vehicle, pet, or package.
- Save decision: whether the user wants the finished brief saved.

Never ask for credentials or private identifiers; the responsible experts resolve their own inputs.

# Generation-time capability evidence

- `ug-surveillance` → `security-monitor-agent`
- `ug-photo` → `photo-agent`
- `ug-knowledge` → `knowledge-agent`

# Workflow

Delegate in this order, and pass only the real result of one step into the step that depends on it.

1. Retrieve the real events. Give the security-monitor expert the location, the time window, and the optional focus, and ask for the ordered event list with one evidence item per event:

`delegate --target security-monitor-agent --instruction 'Query monitoring events for the described location and time window, plus the optional focus. Return the real ordered event list and, for each event, its time, its camera, its event kind, a familiar-or-unknown label where the NAS can decide, and one snapshot or clip evidence item. If nothing matches, return an empty list and say so.'`

2. Enrich the evidence, optionally. When the user wants to know what is visible, pass the real evidence items from step 1 to the photo expert for local image understanding:

`delegate --target photo-agent --instruction 'For each real evidence image returned by the previous monitoring step, use the local vision actions to describe what is visible and to read any legible text such as signage or a plate. Return one short description per image, and report any image that cannot be read instead of guessing.'`

3. Assemble and save the brief. Build the ordered events, the labels, the evidence, and a short narrative summary, then delegate saving to the knowledge expert only after the user agrees:

`delegate --target knowledge-agent --instruction 'Save the provided incident brief text as a single note titled with the location and the time window. Confirm the save result and report any missing part, and do not add events that were not provided.'`

For the brief structure, see [references/incident-brief-format.md](references/incident-brief-format.md). For who the Skill is for and how to use it, see [references/readme.md](references/readme.md). For third-party, license, and AI-tool disclosures, see [references/disclosures.md](references/disclosures.md).

# Completion and failure

Report progress only through the delegation states below.

- completed: the responsible expert returned a real result. State the brief only after a step returns completed. A downstream step runs only on the real result of the step before it; stop a dependent step when its required result is missing.
- failed: name the failing step and keep any earlier real results as a partial brief, clearly marked as partial.
- cancelled: stop, keep the real results already returned, and do not present the run as finished.
- waiting_user: ask for the missing location, window, focus, or save decision, then resume.
- waiting_approval: tell the user that the step is waiting for platform approval, and do not describe the action as done.

If the event list is empty, say clearly that no matching events were found for that location and window, and stop; never substitute a nearby camera, a wider window, or unrelated events.

All NAS work is performed by the delegated experts through the platform; this Skill never calls `cli.invoke` directly.
