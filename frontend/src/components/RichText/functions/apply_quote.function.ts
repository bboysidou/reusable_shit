export const applyQuote = (
  editorRef: React.RefObject<HTMLDivElement | null>,
) => {
  const selection = window.getSelection();
  if (!editorRef.current || !selection || selection.rangeCount === 0) return;

  const range = selection.getRangeAt(0);
  let container = range.commonAncestorContainer;

  if (container.nodeType === Node.TEXT_NODE) {
    container = container.parentElement!;
  }

  const existingQuote = (container as HTMLElement).closest("blockquote");

  if (existingQuote) {
    const content = existingQuote.textContent || "";
    const textNode = document.createTextNode(content);
    existingQuote.parentNode?.replaceChild(textNode, existingQuote);

    const newRange = document.createRange();
    newRange.selectNodeContents(textNode);
    selection.removeAllRanges();
    selection.addRange(newRange);
  } else {
    const blockquote = document.createElement("blockquote");
    blockquote.className =
      "border-l-4 border-muted pl-4 italic text-muted-foreground";

    blockquote.appendChild(range.extractContents());
    range.insertNode(blockquote);

    const newRange = document.createRange();
    newRange.selectNodeContents(blockquote);
    newRange.collapse(false);
    selection.removeAllRanges();
    selection.addRange(newRange);
  }
};
