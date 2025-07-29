import { useCallback, useEffect, useRef, useState } from "react";
import ToolbarRichTextComponent from "./components/Toolbar_rich_text.component";
import { getActiveFormats } from "./functions/get_active_format.function";
import type { ActiveFormatType } from "./functions/types/Active_format.type";
import {
  useController,
  type Control,
  type FieldValues,
  type Path,
} from "react-hook-form";
import { cn } from "@/lib/utils";

interface Props<T extends FieldValues> {
  name: Path<T>;
  control: Control<T>;
  className?: string;
  placeholder?: string;
}

export const RichTextComponent = <T extends FieldValues>({
  name,
  control,
  className,
  placeholder = "Start writing your content here...",
}: Props<T>) => {
  const editorRef = useRef<HTMLDivElement>(null);
  const [activeFormats, setActiveFormats] = useState<ActiveFormatType>({});

  const {
    field: { value, onChange },
  } = useController({
    name,
    control,
  });

  const ensureParagraphExists = useCallback(() => {
    const editor = editorRef.current;
    if (!editor) return;

    if (
      editor.innerHTML.trim() === "" ||
      editor.childNodes.length === 0 ||
      Array.from(editor.childNodes).every(
        (node) => node.nodeType === Node.TEXT_NODE,
      )
    ) {
      const p = document.createElement("div");
      p.innerHTML = "<br>";
      editor.innerHTML = "";
      editor.appendChild(p);

      const range = document.createRange();
      const sel = window.getSelection();
      range.setStart(p, 0);
      range.collapse(true);
      sel?.removeAllRanges();
      sel?.addRange(range);
    }
  }, []);

  const updateActiveFormats = useCallback(() => {
    const formats = getActiveFormats(editorRef);
    setActiveFormats(formats);
  }, []);

  const updateSelection = useCallback(() => {
    setTimeout(updateActiveFormats, 0);
  }, [updateActiveFormats]);

  const handleInput = useCallback(() => {
    updateActiveFormats();
    const html = editorRef.current?.innerHTML || "";
    onChange(html);
  }, [onChange, updateActiveFormats]);

  useEffect(() => {
    if (editorRef.current && value !== editorRef.current.innerHTML) {
      editorRef.current.innerHTML = value || "";
    }

    if (editorRef.current && editorRef.current.innerHTML.trim() === "") {
      ensureParagraphExists();
    }
  }, [value, ensureParagraphExists]);

  return (
    <div className={cn("w-full flex flex-col gap-2", className)}>
      <ToolbarRichTextComponent
        editorRef={editorRef}
        activeFormats={activeFormats}
        updateActiveFormats={updateActiveFormats}
        handleInput={handleInput}
      />
      <div
        ref={editorRef}
        contentEditable
        suppressContentEditableWarning
        className="h-[200px] border rounded-md p-4 focus:outline-none prose dark:prose-invert overflow-y-auto"
        data-placeholder={placeholder}
        onInput={handleInput}
        onKeyUp={updateSelection}
        onMouseUp={updateSelection}
        onFocus={() => {
          ensureParagraphExists();
          updateActiveFormats();
        }}
      />
    </div>
  );
};
