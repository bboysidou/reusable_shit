import type { ActiveFormatType } from "./types/Active_format.type";

export const getActiveFormats = (
  editorRef: React.RefObject<HTMLDivElement | null>,
): ActiveFormatType => {
  if (!editorRef.current) return {};

  const selection = window.getSelection();
  if (!selection || selection.rangeCount === 0) return {};

  const range = selection.getRangeAt(0);
  let parentElement = range.commonAncestorContainer;

  if (parentElement.nodeType === Node.TEXT_NODE) {
    parentElement = parentElement.parentElement!;
  }

  const formats: ActiveFormatType = {};
  let el: HTMLElement | null = parentElement as HTMLElement;

  while (el && el !== editorRef.current) {
    const tag = el.tagName.toLowerCase();

    if (tag === "span" && el.style.fontWeight === "bold") formats.bold = true;
    if (tag === "span" && el.style.fontStyle === "italic")
      formats.italic = true;
    if (tag === "span" && el.style.textDecoration === "underline")
      formats.underline = true;
    if (tag === "h1") formats.heading1 = true;
    if (tag === "h2") formats.heading2 = true;
    if (tag === "h3") formats.heading3 = true;
    if (tag === "ul") formats.bulletList = true;
    if (tag === "ol") formats.numberedList = true;
    if (tag === "blockquote") formats.quote = true;
    if (tag === "pre") formats.code = true;

    el = el.parentElement;
  }

  return formats;
};
