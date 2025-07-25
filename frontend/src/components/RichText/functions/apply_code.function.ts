export const applyCode = (
  editorRef: React.RefObject<HTMLDivElement | null>,
) => {
  const selection = window.getSelection();
  if (!editorRef.current || !selection || selection.rangeCount === 0) return;

  const range = selection.getRangeAt(0);
  let container = range.commonAncestorContainer;

  if (container.nodeType === Node.TEXT_NODE) {
    container = container.parentElement!;
  }

  const existingPre = (container as HTMLElement).closest("pre");

  if (existingPre) {
    // 🔁 Toggle off (unwrap)
    const code = existingPre.querySelector("code");
    const content = code?.textContent || "";
    const textNode = document.createTextNode(content);
    existingPre.parentNode?.replaceChild(textNode, existingPre);

    const newRange = document.createRange();
    newRange.selectNodeContents(textNode);
    selection.removeAllRanges();
    selection.addRange(newRange);
  } else {
    // ✅ Apply code block
    const pre = document.createElement("pre");
    const code = document.createElement("code");

    code.className = "font-mono text-sm";
    code.appendChild(range.extractContents());
    pre.appendChild(code);

    range.insertNode(pre);

    const newRange = document.createRange();
    newRange.selectNodeContents(code);
    newRange.collapse(false);
    selection.removeAllRanges();
    selection.addRange(newRange);
  }
};
