# CLAUDE.md — Frontend Website Rules

## Always Do First
- **Invoke the `frontend-design` skill** before writing any frontend code, every session, no exceptions.

## Reference Images
- If a reference image is provided: match layout, spacing, typography, and color exactly. Swap in placeholder content (images via `https://placehold.co/`, generic copy). Do not improve or add to the design.
- If no reference image: design from scratch with high craft (see guardrails below).

## Local Server
- Server serves the project root at `http://localhost:3000` via `serve.mjs`
- Start: `node serve.mjs &` (check first with `lsof -i :3000` to avoid duplicates)

## Output Defaults
- Single `index.html` file, all styles inline, unless user says otherwise
- Tailwind CSS via CDN: `<script src="https://cdn.tailwindcss.com"></script>`
- Placeholder images: `https://placehold.co/WIDTHxHEIGHT`
- Mobile-first responsive

## Brand Assets
- Always check the `brand_assets/` folder before designing. It may contain logos, color guides, style guides, or images.
- If assets exist there, use them. Do not use placeholders where real assets are available.
- If a logo is present, use it. If a color palette is defined, use those exact values — do not invent brand colors.

## Anti-Generic Guardrails
- **Colors:** Never use default Tailwind palette (indigo-500, blue-600, etc.). Pick a custom brand color and derive from it.
- **Shadows:** Never use flat `shadow-md`. Use layered, color-tinted shadows with low opacity.
- **Typography:** Never use the same font for headings and body. Pair a display/serif with a clean sans. Apply tight tracking (`-0.03em`) on large headings, generous line-height (`1.7`) on body.
- **Gradients:** Layer multiple radial gradients. Add grain/texture via SVG noise filter for depth.
- **Animations:** Only animate `transform` and `opacity`. Never `transition-all`. Use spring-style easing.
- **Interactive states:** Every clickable element needs hover, focus-visible, and active states. No exceptions.
- **Images:** Add a gradient overlay (`bg-gradient-to-t from-black/60`) and a color treatment layer with `mix-blend-multiply`.
- **Spacing:** Use intentional, consistent spacing tokens — not random Tailwind steps.
- **Depth:** Surfaces should have a layering system (base → elevated → floating), not all sit at the same z-plane.

## Hard Rules
- Do not add sections, features, or content not in the reference
- Do not "improve" a reference design — match it
- Do not use `transition-all`
- Do not use default Tailwind blue/indigo as primary color

---

## Folder Structure

```
musastudiosco website/
├── index.html              — Homepage
├── styles.css              — Global styles
├── pages/                  — One HTML file per portfolio section
├── brand_assets/           — Logos, color swatches, brand identity artboards
├── projects/               — All portfolio project content (copy + assets)
│   ├── print-design/
│   │   ├── event-posters/
│   │   └── artistic-posters/
│   ├── brand-identity/
│   ├── digital-art/
│   ├── digital-design/
│   ├── graphic-design/
│   ├── photo-compositing/
│   ├── retouching/
│   └── traditional-art/
├── _intake/                — Drop zone for new projects (see below)
└── website inspiration/    — Reference images for design direction
```

Each project inside `projects/` is a self-contained folder:
```
projects/print-design/event-posters/Born2Create/
├── copy.md       — Written portfolio copy (generated)
└── Born2Create.png
```

---

## New Project Intake Workflow

When the user says a new project has been added to `_intake/`:

1. **Read** `_intake/[ProjectName]/brief.md` — structured YAML front matter + description fields
2. **Inspect** all image assets in the same folder
3. **Write copy** to `_intake/[ProjectName]/copy.md` following the copy style below
4. **Move** the entire project folder (brief.md, copy.md, assets) to the correct location in `projects/[section]/[subsection]/[ProjectName]/`
5. **Integrate** into the appropriate `pages/[section].html` — choose the layout that best serves the work (full-bleed hero, grid card, modal lightbox, etc.)

### Copy Style Guide
- Lead with the concept, not the process — open with what the piece *is*, not what steps were taken
- Emphasize design principles over chronology: hierarchy, contrast, color theory, grid, typographic choice
- Use confident, specific language — "stark monochrome" not "black and white look"
- Max 3 paragraphs: (1) Concept/intent, (2) Key design decisions, (3) Principles applied
- No filler phrases ("In conclusion", "Overall", "At the end of the day")
- Tone: a senior designer talking to a creative director — knowledgeable, precise, unhurried

### brief.md Front Matter Fields
```yaml
title: "Project Title"
section: "graphic-digital-design" # maps to projects/ subfolder and pages/*.html
subsection: "event-posters"      # optional subcategory
client: "Client Name or Personal"
date: "2026"
```

### Section → Page Mapping
| section value | HTML file |
|---|---|
| graphic-digital-design | pages/graphic-digital-design.html |
| brand-identity | pages/brand-identity.html |
| digital-art | pages/digital-art.html |
| photo-compositing | pages/photo-retouching.html |
| retouching | pages/photo-retouching.html |
| traditional-art | pages/traditional-art.html |

Note: print-design, digital-design, and graphic-design have been merged into `graphic-digital-design`. All three section values map to `pages/graphic-digital-design.html`. Print Design project assets live under `projects/graphic-digital-design/print-design/`. Photo-compositing and retouching are also merged — both map to `pages/photo-retouching.html`, assets under `projects/photo-compositing/`.
