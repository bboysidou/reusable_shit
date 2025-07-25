export const getSelectedText = (
  editorRef: React.RefObject<HTMLDivElement | null>,
) => {
  const selection = window.getSelection();
  if (!selection || selection.rangeCount === 0) return null;

  const range = selection.getRangeAt(0);
  let selectedText = range.toString();

  if (!selectedText && editorRef.current?.contains(range.startContainer)) {
    const textNode = range.startContainer;
    if (textNode.nodeType === Node.TEXT_NODE) {
      const text = textNode.textContent || "";
      const offset = range.startOffset;

      let start = offset;
      let end = offset;

      while (start > 0 && /\w/.test(text[start - 1])) start--;
      while (end < text.length && /\w/.test(text[end])) end++;

      if (start < end) {
        range.setStart(textNode, start);
        range.setEnd(textNode, end);
        selection.removeAllRanges();
        selection.addRange(range);
        selectedText = text.slice(start, end);
      }
    }
  }

  return { range, selectedText };
};
