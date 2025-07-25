import { useCallback, useRef, useState } from "react";
import ToolbarRichTextComponent from "./components/Toolbar_rich_text.component";
import { getActiveFormats } from "./functions/get_active_format.function";
import type { ActiveFormatType } from "./functions/types/Active_format.type";

export const RichTextComponent = () => {
  const editorRef = useRef<HTMLDivElement>(null);
  const [activeFormats, setActiveFormats] = useState<ActiveFormatType>({});

  const updateActiveFormats = useCallback(() => {
    const formats = getActiveFormats(editorRef);
    setActiveFormats(formats);
  }, []);

  const handleSelectionChange = useCallback(() => {
    setTimeout(updateActiveFormats, 0);
  }, [updateActiveFormats]);

  const handleInput = useCallback(() => {
    updateActiveFormats();
  }, [updateActiveFormats]);

  const handleKeyUp = useCallback(() => {
    updateActiveFormats();
  }, [updateActiveFormats]);

  const handleMouseUp = useCallback(() => {
    updateActiveFormats();
  }, [updateActiveFormats]);

  return (
    <div className="flex flex-col gap-2">
      <ToolbarRichTextComponent
        editorRef={editorRef}
        activeFormats={activeFormats}
      />
      <div
        ref={editorRef}
        contentEditable
        suppressContentEditableWarning
        className="min-h-[200px] border rounded-md p-4 focus:outline-none focus:ring-2 focus:ring-primary prose dark:prose-invert"
        data-placeholder="Start writing your content here..."
        onInput={handleInput}
        onKeyUp={handleKeyUp}
        onMouseUp={handleMouseUp}
        onFocus={handleSelectionChange}
      />
    </div>
  );
};

export default RichTextComponent;
