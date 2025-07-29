import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { useCallback, useState } from "react";
import { testSchema, type TestType } from "@/schemas/test.schema";
import { CustomInput } from "@/components/CustomForm/Custom_input.component";
import { Form } from "@/components/ui/form";
import ActionButtonLayout from "@/components/ActionButton/Action_button.component";
import { RichTextComponent } from "@/components/RichText/Rich_text.component";

const FormTest = () => {
  const [loading, setLoading] = useState<boolean>(false);
  const form = useForm<TestType>({
    resolver: zodResolver(testSchema),
  });

  const onSubmit = useCallback((data: TestType) => {
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      console.log(data);
    }, 100);
  }, []);

  return (
    <Form {...form}>
      <form
        className="w-[600px] flex flex-col gap-4 p-4"
        onSubmit={form.handleSubmit(onSubmit)}
      >
        <h1 className="text-2xl font-bold">
          Test Form {loading && "(loading)"}
        </h1>
        <CustomInput
          control={form.control}
          name="name"
          label="Name"
          placeholder="John Doe"
          type="text"
        />
        <CustomInput
          control={form.control}
          name="description"
          label="Description"
          placeholder="John Doe"
          renderInput={(field) => (
            <RichTextComponent name={field.name} control={form.control} />
          )}
        />
        <ActionButtonLayout type="submit" disabled={loading}>
          Submit
        </ActionButtonLayout>
        <ActionButtonLayout
          disabled={loading}
          withConfirmation
          confirmationMessage="Are you sure?"
          onClick={(e) => form.handleSubmit(onSubmit)(e)}
        >
          Submit with confirmation
        </ActionButtonLayout>
      </form>
    </Form>
  );
};

export default FormTest;
