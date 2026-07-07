---
name: explain-diff-notion
description: Use when the user asks for a rich explanation of a code change, diff, branch, or PR. Produces a Notion page.
metadata:
    source-gist: https://gist.github.com/geoffreylitt/a29df1b5f9865506e8952488eac3d524
    source-file: explain-diff-notion.md
    source-revision: 126e7fe9
---

# Explain Diff

Please make me a rich, interactive explanation of the specified code change as a Notion page.

It should have these sections:

- Background: Explain the existing system relevant to this change. (You should broadly explore surrounding code for this.) We don't know how much the reader already knows, so include a deep background for beginners (note that it can be skipped if the reader is already familiar), and then a more narrow background directly relevant to the change.
- Intuition: Explain the core intuition for the code change. The focus here is to explain the essence, not the full details. Use concrete examples with toy data. Use figures and diagrams liberally.
- Code: Do a high-level walkthrough of the changes to the code. Group/order the changes in an understandable way.
- **Quiz**: Come up with 5 questions that test the reader's knowledge of this PR. This should be medium difficulty, difficult enough that you actually need to understand the substance of the PR to answer them, but not gotchas. The goal is to help the reader make sure that they've actually understood. Each question should have some multiple choice answers with an explanation detailing why an answer is correct or incorrect. Use toggle blocks to represent this. For example:
  ```markdown
  1. Question
     ▶ Option 1
      ❌ Explanation for why it was incorrect
     ▶ Option 2
      ❌ Explanation for why it was incorrect
     ▶ Option 3
      ✅ Explanation for why it was correct
     ▶ Option 4
       ❌ Explanation for why it was incorrect
  2. Question
     ...
  ```
  
Format:

- Use the Notion MCP tools to create a new page and return the URL of the new page.
- Please write with the clarity and flow of Martin Kleppmann, making it engaging and written in classic style. Transitions between sections should be smooth.
- Some tips on diagrams. Ideally, you should pick a small number of diagram families that can be reused throughout the explanation to explain various cases. Make sure to include example data!
- Use callouts for key concepts or definitions, important edge cases, etc.
