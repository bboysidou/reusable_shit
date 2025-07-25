export const applyList = (type: "ul" | "ol") => {
  const selection = window.getSelection();
  if (!selection || selection.rangeCount === 0) return;

  const range = selection.getRangeAt(0);
  let parentElement = range.commonAncestorContainer;

  if (parentElement.nodeType === Node.TEXT_NODE) {
    parentElement = parentElement.parentElement!;
  }

  const existingList = (parentElement as Element).closest("ul, ol");
  const existingListItem = (parentElement as Element).closest("li");

  if (existingList && existingListItem) {
    const textContent = existingListItem.textContent || "";
    const pElement = document.createElement("p");
    pElement.textContent = textContent;

    if (existingList.children.length === 1) {
      existingList.parentNode?.replaceChild(pElement, existingList);
    } else {
      existingListItem.parentNode?.replaceChild(pElement, existingListItem);
    }

    const newRange = document.createRange();
    newRange.selectNodeContents(pElement);
    selection.removeAllRanges();
    selection.addRange(newRange);
  } else {
    const listElement = document.createElement(type);
    listElement.className =
      type === "ol"
        ? "list-decimal list-inside ml-4"
        : "list-disc list-inside ml-4";

    const listItem = document.createElement("li");
    const content = range.toString();
    listItem.textContent = content;
    listElement.appendChild(listItem);

    range.deleteContents();
    range.insertNode(listElement);

    const newRange = document.createRange();
    newRange.selectNodeContents(listItem);
    newRange.collapse(false);
    selection.removeAllRanges();
    selection.addRange(newRange);
  }
};
