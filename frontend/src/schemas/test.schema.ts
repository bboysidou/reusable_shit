import { z } from "zod";

export const testSchema = z.object({
  name: z.string({ message: "Name is required" }),
  description: z.string({ message: "Description is required" }),
});

export type TestType = z.infer<typeof testSchema>;
