# COMPONENTS - Frontend Components

**Scope**: Component directory `memora-frontend/src/components`
**Generated**: 2025-01-21

## Overview
React component library for the Memora frontend.

## Structure
```
memora-frontend/src/components/
├── Dashboard.jsx              # Main dashboard component (1534 lines, highest complexity)
├── Header.jsx
├── Sidebar.jsx
├── MemoryCard.jsx
├── Modal/
├── Form/
└── Layout/
```

## Where To Look
| Task | Location | Notes |
|------|----------|-------|
| Main dashboard logic | Dashboard.jsx | 20+ state variables, 8+ useEffect hooks |
| Navigation components | Header.jsx, Sidebar.jsx | Standard routing integration |
| Memory display | MemoryCard.jsx | Card-based memory rendering |
| Modal dialogs | Modal/ | Reusable modal components |
| Form components | Form/ | Input forms and validation |
| Layout wrappers | Layout/ | Page layout components |

## Conventions
- Functional components with hooks
- Tailwind CSS for styling
- React Router integration
- State management via useState/useEffect
- Props destructuring

## Anti-Patterns (This Project)
- **Dashboard.jsx complexity**: Mixing UI and business logic - consider splitting concerns
- **State sprawl**: Too many useState hooks in single component

## Notes
- Dashboard.jsx is the most complex component with 1534 lines
- Mixed concerns in Dashboard.jsx could benefit from custom hooks extraction
- State management could be improved with context or useReducer for complex components