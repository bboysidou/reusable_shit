export const applyFormat = (
  editorRef: React.RefObject<HTMLDivElement | null>,
  tag: "bold" | "italic" | "underline",
) => {
  const tagName = "span";

  const selection = window.getSelection();
  if (!editorRef.current || !selection || selection.rangeCount === 0) return;

  const range = selection.getRangeAt(0);
  if (selection.isCollapsed) return;
  let element: HTMLElement | null =
    range.commonAncestorContainer as HTMLElement;

  if (element.nodeType === Node.TEXT_NODE) {
    element = element.parentElement;
  }

  const contents = document.createElement(tagName);
  if (!contents) return;
  switch (tag) {
    case "bold": {
      const isBold = isActiveFormat({ node: contents, tag: "bold" });
      contents.style.fontWeight = isBold ? "normal" : "bold";
      break;
    }

    case "italic": {
      const isItalic = isActiveFormat({ node: contents, tag: "italic" });
      contents.style.fontStyle = isItalic ? "normal" : "italic";
      break;
    }

    case "underline": {
      const isUnderlined = isActiveFormat({ node: contents, tag: "underline" });
      contents.style.textDecoration = isUnderlined ? "none" : "underline";
      break;
    }
  }
  contents.appendChild(range.extractContents());
  range.insertNode(contents);
};

function isActiveFormat({
  node,
  tag,
}: {
  node: HTMLElement;
  tag: "bold" | "italic" | "underline";
}) {
  switch (tag) {
    case "bold": {
      return node.style.fontWeight === "bold";
    }
    case "italic": {
      return node.style.fontStyle === "italic";
    }
    case "underline": {
      return node.style.textDecoration === "underline";
    }
    default: {
      return false;
    }
  }
}
