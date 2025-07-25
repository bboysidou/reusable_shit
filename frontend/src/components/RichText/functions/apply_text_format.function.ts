export const applyFormat = (
  editorRef: React.RefObject<HTMLDivElement | null>,
  tag: "bold" | "italic" | "underline",
) => {
  const selection = window.getSelection();
  if (!editorRef.current || !selection || selection.rangeCount === 0) return;

  const range = selection.getRangeAt(0);
  const tagName = tag === "bold" ? "strong" : tag === "italic" ? "em" : "u";
  const className =
    tag === "bold" ? "font-bold" : tag === "italic" ? "italic" : "underline";

  let parentElement = range.commonAncestorContainer;
  if (parentElement.nodeType === Node.TEXT_NODE) {
    parentElement = parentElement.parentElement!;
  }

  const existingElement = (parentElement as Element).closest(tagName);
  if (existingElement && existingElement.classList.contains(className)) {
    const textContent = existingElement.textContent || "";
    const textNode = document.createTextNode(textContent);
    existingElement.parentNode?.replaceChild(textNode, existingElement);
    const newRange = document.createRange();
    newRange.selectNodeContents(textNode);
    selection.removeAllRanges();
    selection.addRange(newRange);
    return;
  }

  const element = document.createElement(tagName);
  element.className = className;

  if (range.collapsed) {
    element.innerHTML = "\u200B";
    range.insertNode(element);
    const newRange = document.createRange();
    newRange.setStart(element.firstChild!, 1);
    newRange.collapse(true);
    selection.removeAllRanges();
    selection.addRange(newRange);
    return;
  }

  const content = range.extractContents();
  element.appendChild(content);
  range.insertNode(element);

  const newRange = document.createRange();
  newRange.selectNodeContents(element);
  newRange.collapse(false);
  selection.removeAllRanges();
  selection.addRange(newRange);
};
