import { useMemo, type ReactNode } from "react";
import {
  Bold,
  Italic,
  List,
  ListOrdered,
  Underline,
  Heading1,
  Heading2,
  Heading3,
  Quote,
  Code,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { applyFormat } from "../functions/apply_text_format.function";
import { applyBlockTag } from "../functions/apply_block_tag.function";
import { applyList } from "../functions/apply_list.function";
import type { ActiveFormatType } from "../functions/types/Active_format.type";
import { cn } from "@/lib/utils";
import { applyQuote } from "../functions/apply_quote.function";
import { applyCode } from "../functions/apply_code.function";

interface Props {
  editorRef: React.RefObject<HTMLDivElement | null>;
  activeFormats: ActiveFormatType;
}

interface ButtonProps {
  command: () => void;
  icon: ReactNode;
  isActive?: boolean;
}

const ToolbarRichTextComponent = ({ editorRef, activeFormats }: Props) => {
  const buttons: ButtonProps[] = useMemo(() => {
    return [
      {
        command: () => applyFormat(editorRef, "bold"),
        icon: <Bold className="w-4 h-4" />,
        isActive: activeFormats.bold,
      },
      {
        command: () => applyFormat(editorRef, "italic"),
        icon: <Italic className="w-4 h-4" />,
        isActive: activeFormats.italic,
      },
      {
        command: () => applyFormat(editorRef, "underline"),
        icon: <Underline className="w-4 h-4" />,
        isActive: activeFormats.underline,
      },
      {
        command: () => applyBlockTag("h1"),
        icon: <Heading1 className="w-4 h-4" />,
        isActive: activeFormats.heading1,
      },
      {
        command: () => applyBlockTag("h2"),
        icon: <Heading2 className="w-4 h-4" />,
        isActive: activeFormats.heading2,
      },
      {
        command: () => applyBlockTag("h3"),
        icon: <Heading3 className="w-4 h-4" />,
        isActive: activeFormats.heading3,
      },
      {
        command: () => applyList("ul"),
        icon: <List className="w-4 h-4" />,
        isActive: activeFormats.bulletList,
      },
      {
        command: () => applyList("ol"),
        icon: <ListOrdered className="w-4 h-4" />,
        isActive: activeFormats.numberedList,
      },
      {
        command: () => applyQuote(editorRef),
        icon: <Quote className="w-4 h-4" />,
        isActive: activeFormats.quote,
      },
      {
        command: () => applyCode(editorRef),
        icon: <Code className="w-4 h-4" />,
        isActive: activeFormats.code,
      },
    ];
  }, [editorRef, activeFormats]);

  return (
    <div className="flex flex-wrap gap-1 border p-2 rounded-md bg-muted">
      {buttons.map((command, index) => (
        <Button
          key={index}
          variant="ghost"
          className={cn(
            "h-8 px-3 border transition-all duration-200",
            command.isActive
              ? "bg-primary text-primary-foreground border-primary shadow-sm"
              : "border-transparent hover:bg-toolbar-hover hover:border-editor-border",
          )}
          onClick={() => {
            editorRef.current?.focus();
            command.command();
          }}
        >
          {command.icon}
        </Button>
      ))}
    </div>
  );
};

export default ToolbarRichTextComponent;
