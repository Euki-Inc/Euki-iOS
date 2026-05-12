# YAPP Transformation: GigaPrompt and Automation Blueprint

## Phase 1: GigaPrompt for GPT-5 Code Interpreter

Below is a one-shot prompt designed for GPT-5 Code Interpreter to transform a "lovable.dev" React/Vite web app into a fully functional YAPP (mobile-first app), following an Architect & Builder agent paradigm. The prompt instructs the model to split into two roles – Architect (plans the refactor step-by-step) and Builder (executes code transformations) – in line with an agent-to-agent (A2A) collaboration approach【18†】. It also integrates UI/UX best practices from Steve Krug (“Don’t Make Me Think”) and Steve Schoger’s Refactoring UI guidelines to ensure the result is polished and intuitive. The prompt is ready to copy-paste into GPT-5:

---

You are GPT-5 Code Interpreter, operating as two cooperative agents: an **Architect** and a **Builder**.

**Goal:** Refactor the provided **lovable.dev** React/Vite web app (zipped input) into a **YAPP** – a mobile-first, polished application – while preserving its web preview for desktop. The YAPP must meet these requirements:
- **Mobile Rebuild:** Rebuild the front-end as a modern mobile app using **Expo (React Native)**. Design with a **mobile-first** approach using contemporary UI trends (e.g. glassmorphism panels, fluid/liquid interactions, animated hero sections).
- **Desktop Preview:** Preserve or enhance the original web frontend for desktop viewing (e.g. via React Native Web or by retaining a Vite web build) so the app remains viewable on the user’s profile (lovable.dev web preview).
- **Unified Dashboard:** Inject a **universal internal dashboard** (admin console) into the app for managing workflows/integrations. This dashboard should have a consistent UX across all YAPPs (e.g. side-nav menu, settings pages, integration toggles).
- **Backend Integration:** Use the **Lovable Cloud** backend (include any provided schema and data). Ensure the refactored app connects to the same database/API or migrates it seamlessly, so all original data and functionality persist.
- **AI & Workflow Ready:** Prepare the app for one-click integration of **AI agents and workflow automations** (hosted on the studio’s server). Include hooks or modules for integrating N8N/agent workflows (e.g. API endpoints or SDK calls to trigger AI agents) – these can be stubbed or sample implementations if actual endpoints aren’t provided.
- **Offline Capability:** Make the app **offline-ready**. For mobile, use caching or local storage (e.g. AsyncStorage or SQLite via Expo) so core features work without internet. For web/PWA, include a Service Worker for offline support if possible.
- **Cross-Platform Build:** Ensure the project can build for **iOS and Android**. Configure either Expo EAS or Capacitor so that with minimal effort the app can be packaged for both platforms (include appropriate config files, e.g. `app.json`/`eas.json` or `capacitor.config.json`). Verify the app runs on both device types and passes basic store requirements (icons, splash screen, versioning).

**Quality & UI/UX Requirements:**
- **Modern Aesthetics:** Apply a clean, modern design inspired by *Refactoring UI*. Embrace whitespace and clear visual hierarchy:contentReference[oaicite:0]{index=0}. Use a harmonious color palette and consistent, readable font sizes:contentReference[oaicite:1]{index=1}. Implement glassmorphism effects (blurred translucent backgrounds) for cards or modals, and an attractive animated hero section (e.g. a looping subtle animation or interactive header) to make the app feel alive.
- **Intuitive Usability:** Follow Steve Krug’s usability principles (Don’t Make Me Think:contentReference[oaicite:2]{index=2}). All navigation and actions should be obvious. Use familiar icons and labels for buttons (e.g. a magnifying glass for search, “X” for close) and ensure interactive elements are clearly distinguishable (e.g. buttons with consistent styling and hover/touch feedback). Simplify user flows: minimize the number of taps to perform key actions and prefer in-place interactions (e.g. modal overlays for details rather than full page jumps):contentReference[oaicite:3]{index=3}.
- **Consistent Components:** Refactor any existing UI components into reusable **React Native components**. Use a design system or component library where it speeds development (Expo’s built-in components, or libraries like React Native Paper/Elements for common UI). Ensure consistent spacing, alignment, and styling across the app (e.g. uniform padding, matching corner radii, shadow styles) for a professional look:contentReference[oaicite:4]{index=4}:contentReference[oaicite:5]{index=5}.
- **Performance & Polish:** Optimize images and assets for mobile. Implement skeleton loaders or placeholders for any remote data (to avoid blank screens during load). Ensure transitions are smooth (use React Native’s Animated API or Reanimated for interactive gestures/animations). Aim for 60fps feel; avoid heavy operations on the main thread. Test the app on different screen sizes (small phones to tablets) to confirm responsive layout.

**Your Roles & Process:**
1. **Architect (Step 1 – Analysis & Plan):** Begin by examining the input zip’s code structure. Identify main React components, pages, assets, and any backend/API usage (e.g. look for `.env` files, API calls, or database config). Summarize the app’s functionality and data schema. Then, devise a step-by-step refactoring plan to meet the above goals. Break the plan into clear tasks for the Builder (e.g. “Task 1: Initialize Expo project; Task 2: Convert main page to RN; Task 3: Implement navigation; Task 4: Add glassmorphism styling to cards; …, Task X: Setup iOS/Android build configs” etc.). Pay special attention to integrating the internal dashboard module and preserving any unique features of the original app.
2. **Builder (Step 2 – Execution):** Follow the Architect’s plan precisely, modifying and generating code. For each task:
   - Explain briefly **what** you are about to implement and **why** (to maintain clarity).
   - Provide the **code** or file changes needed to accomplish the task. Use the Code Interpreter’s abilities to create new files or refactor existing ones. Ensure the code is well-structured (e.g. use Expo’s project structure with `App.js`/`App.tsx`, a `/components` directory for UI components, etc.).
   - After each code snippet or file output, **validate** if the change achieves the intended outcome (e.g. the app compiles, the UI component renders as expected, no lint errors).
   - Proceed through tasks incrementally, only moving to the next after confirming the previous step’s success. If an issue arises (e.g. a dependency error), fix it as part of the current step.
3. **Architect (Review & Next Steps):** After all tasks are executed, perform a final review. Ensure the refactored YAPP meets the requirements:
   - The app loads on mobile without errors, and all primary features of the original are present.
   - UI/UX checks: The interface should be clean and consistent (no obvious visual glitches, text too small, etc.), controls are easy to use, and the design reflects the requested modern style.
   - The internal dashboard is accessible (e.g. perhaps via a hidden button or an admin login), and includes at least a placeholder UI for managing integrations (for example, a screen listing “AI Workflows” with dummy toggles or status, which can later be wired to real data).
   - Offline mode: simulate no internet – the app should still allow navigation or show cached content gracefully (you may implement a simple caching of data or a notice “You are offline” for sections that require live data).
   - Building: Confirm that platform build files/configurations are in place (e.g. run `npx expo export` or similar if possible to ensure web build, check that `eas.json` or Capacitor config exists with sample App ID).
   - Document any important **instructions or environment setup** needed to run or build the new app (e.g. required environment variables, how to run on web vs mobile, etc.).

Output the fully refactored project files and a brief summary. The summary should highlight how each of the YAPP goals was achieved (e.g. “Rebuilt UI in React Native, added Expo BlurView for glassmorphism, etc.”) and list any follow-up steps or TODOs (especially if some integration points are stubbed).

Throughout this process, prioritize **clean, functional code** and **excellent UX**. The end result should be a **deployable YAPP** that feels like a professional mobile app while retaining the original app’s spirit and data.

Begin now.
