# Disclosures

## Third-party components and open source libraries

The Skill package is authored entirely in Markdown and contains no third-party
code, no open source libraries, and no bundled dependencies. It therefore carries
no third-party license obligations at runtime.

## Runtime dependencies

None beyond the UGREEN AI NAS platform itself. The Skill calls only published
platform capabilities through the registered experts.

## Development-time tools

- The official UGREEN Uliya Skill Creation Tool (`uliya-skill-kit`) was used to
  confirm capabilities and to run the official static check. It is a development
  tool and is not bundled in this package.
- The separate project proposal document was typeset with Typst (source:
  https://github.com/typst/typst, license: Apache-2.0). Typst is not part of this
  Skill package.

## Principal functionality developed for this Hackathon

The incident-review workflow: the orchestration that turns a reported location and
time window into an ordered, evidence-backed incident brief. This includes the
delegation order across the security-monitor, photo, and knowledge experts, the
brief structure, the empty-result behavior, and the handling of every delegation
state. This work was created for the Hackathon.

## AI tools used and their principal uses

- An AI coding assistant was used during development to draft the Skill and its
  reference files and to run the official static checker. It does not run on the
  NAS.
- At runtime the Skill relies on the UGREEN AI NAS local AI models for event
  detection and local image understanding. All processing stays on the device.

## Configuration

No configuration template is required. The Skill needs no keys, endpoints, or
saved secrets, and it stores nothing of its own.
