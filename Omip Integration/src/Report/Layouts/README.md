# Layouts Organization

This folder contains all the Word layout files (.docx) for reports organized by marketer and document type.

## Structure

```
Layouts/
├── Contracts/
│   ├── Nabalia/        # Nabalia contract layouts
│   ├── Acis/           # Acis contract layouts
│   └── Avanza/         # Avanza contract layouts
├── Proposals/
│   ├── Nabalia/        # Nabalia proposal layouts
│   ├── Acis/           # Acis proposal layouts
│   └── Avanza/         # Avanza proposal layouts
└── Common/             # Shared layouts (CopyEmail templates)
```

## File Organization

### Contracts
- **Nabalia**: Contains electricity and gas contract layouts including Single/Multi CUPS variants and Fixed/Indexed gas rates
- **Acis**: Contains electricity contract layouts with Single/Multi CUPS variants
- **Avanza**: Contains electricity contract layouts with Single/Multi CUPS variants

### Proposals
- **Nabalia**: Contains OMIP and energy proposal layouts
- **Acis**: Contains OMIP proposal layouts with Single/Multi CUPS variants
- **Avanza**: Contains OMIP proposal layouts with Single/Multi CUPS variants

### Common
- Contains shared email copy templates for all marketers

## Naming Convention

### Contracts
- `SUCOmipContract12M[MARKETER][_TYPE][_CUPS].docx`
- Examples:
  - `SUCOmipContract12MNAB.docx` (Nabalia 12M Single CUPS)
  - `SUCOmipContract12MMCNAB.docx` (Nabalia 12M Multi CUPS)
  - `SUCOmipContract12MNAB_GasFixed.docx` (Nabalia Gas Fixed)

### Proposals
- `SUCOmipProposal[MARKETER][MC].docx`
- Examples:
  - `SUCOmipProposalNAB.docx` (Nabalia Single CUPS)
  - `SUCOmipProposalNABMC.docx` (Nabalia Multi CUPS)

## Benefits

1. **Clear Organization**: Each marketer has its own folder
2. **Easy Navigation**: Separate folders for contracts and proposals
3. **Scalability**: Easy to add new marketers or layout types
4. **Maintainability**: Isolated changes per marketer
5. **Shared Resources**: Common layouts in dedicated folder
