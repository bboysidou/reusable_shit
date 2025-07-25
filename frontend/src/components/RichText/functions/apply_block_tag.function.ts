export const applyBlockTag = (
  tagName: "h1" | "h2" | "h3" | "h4" | "h5" | "h6",
) => {
  const selection = window.getSelection();
  if (!selection || selection.rangeCount === 0) return;

  const range = selection.getRangeAt(0);
  let parentElement = range.commonAncestorContainer;

  if (parentElement.nodeType === Node.TEXT_NODE) {
    parentElement = parentElement.parentElement!;
  }

  const existingHeading = (parentElement as Element).closest(
    "h1, h2, h3, h4, h5, h6",
  );

  if (existingHeading) {
    const textContent = existingHeading.textContent || "";
    const pElement = document.createElement("p");
    pElement.textContent = textContent;
    existingHeading.parentNode?.replaceChild(pElement, existingHeading);

    const newRange = document.createRange();
    newRange.selectNodeContents(pElement);
    selection.removeAllRanges();
    selection.addRange(newRange);
  } else {
    const element = document.createElement(tagName);
    element.className =
      tagName === "h1"
        ? "text-3xl"
        : tagName === "h2"
          ? "text-2xl"
          : tagName === "h3"
            ? "text-xl"
            : tagName === "h4"
              ? "text-lg"
              : tagName === "h5"
                ? "text-base"
                : "text-sm";

    const content = range.toString();
    element.textContent = content;

    range.deleteContents();
    range.insertNode(element);

    const newRange = document.createRange();
    newRange.selectNodeContents(element);
    newRange.collapse(false);
    selection.removeAllRanges();
    selection.addRange(newRange);
  }
};
