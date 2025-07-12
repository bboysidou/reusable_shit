import { z } from "zod";

export const testSchema = z.object({
  name: z.string({ message: "Name is required" }),
});

export type TestType = z.infer<typeof testSchema>;
