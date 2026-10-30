#set page(paper: "a4", margin: (x: 1.7cm, y: 1.6cm))
#set text(font: ("Noto Sans", "DejaVu Sans"), size: 9.5pt, lang: "en")
#set par(justify: true, leading: 0.62em, spacing: 0.55em)

#show heading.where(level: 1): it => block(above: 0.85em, below: 0.3em)[
  #set text(size: 10pt, weight: "bold")
  #it
]

#align(center)[
  #text(size: 17pt, weight: "bold")[Incident Review]
  #v(0.2em)
  #text(size: 10pt)[A UGREEN AI NAS Skill — Open Innovation track]
]

#v(0.5em)

#text(size: 8.5pt, fill: luma(90))[
  *Skill name:* `incident-review` #h(1.2em) *Deliverable:* pre-test Skill package (`SKILL.md` + one reference) \
  *Platform:* UGREEN NAS / UGOS Surveillance Center and local AI
]

#v(0.3em)

#heading(level: 1)[1. What does your Skill do?]
Incident Review turns a rough report about something that happened on premises into a short, timestamped brief built only from the UGREEN NAS's real surveillance events and evidence.

#heading(level: 1)[2. Who is your target user, and what is their problem?]
On-site security staff and small-business owners running cameras on a UGREEN NAS. When an incident is reported, reconstructing it means scrubbing hours of footage by hand — slow and error-prone.

#heading(level: 1)[3. What is your solution?]
Given a location and a rough time window, the Skill queries the NAS's local AI event index, orders the candidate events, labels each person or vehicle familiar or unknown, attaches one snapshot or clip each, and writes a short narrative brief.

#heading(level: 1)[4. What is the main user flow?]
The user reports an incident; the Skill confirms location, window, and optional focus, retrieves events and evidence, optionally describes the evidence images locally, then builds and, with consent, saves the brief.

#heading(level: 1)[5. How is your idea different from existing tools or common AI solutions?]
Cloud AI-camera tools ship footage off-device or merely list detections. This runs entirely on the NAS, over its own recorded events, returning an evidence-backed narrative that never leaves the device.

#heading(level: 1)[6. Which UGREEN AI NAS features does your Skill use, and at which step?]
Step 1 uses Monitoring Center local AI detection and event search (intrusion, face, vehicle, pet, package; familiar-versus-unknown labeling; event clips). Step 2 uses local image description and text reading. Step 3 saves the note.

#heading(level: 1)[7. What is your technical approach?]
Expert delegation orchestrates the work: `ug-surveillance` (cameras, event-timeline, identity-resolve, event-evidence) to `security-monitor-agent`; `ug-photo` (vision-vlm, vision-ocr) to `photo-agent`; `ug-knowledge` (save-text) to `knowledge-agent`. Reads are read-only; saving needs user confirmation and platform approval. Only on-device models are used; nothing is sent externally.

#heading(level: 1)[8. What have you built so far? What is not built yet? What still needs testing on a NAS?]
Built: the complete `SKILL.md` (goal, required input, capability evidence, delegation order, and completion and failure handling) plus a brief-format reference; it passes the official static checker with zero errors and warnings. Not built: execution on real hardware. Needs NAS testing: event throughput and evidence quality.

#heading(level: 1)[9. How will you test your Skill if you become a Finalist?]
Core case A — a known person enters the storeroom inside the window: expect an ordered list, a familiar label, and a clip. Core case B — a package is removed: expect a package event, evidence, and an unknown label. Edge case — an empty window: expect a clear no-matches message.

#heading(level: 1)[10. What are the known limits, risks, or outside dependencies of your Skill?]
Events come only from cameras the NAS manages, and only when the user enables local AI detection; the AI event index covers roughly the past 15 days; strangers stay unknown unless enrolled; detection can miss or mislabel, so a human confirms. Dependency: a UGREEN NAS with Surveillance Center and local AI detection enabled.

#v(0.5em)
#text(size: 8.5pt)[
  *Third-party components:* none. The Skill is Markdown only and uses no external libraries or services, so no third-party license obligations apply. An AI coding assistant was used to draft the Skill and to check it against the official Uliya Skill Development Standard.
]
