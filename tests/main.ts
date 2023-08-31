import { assert } from "https://deno.land/std@0.200.0/assert/mod.ts";
import { walk } from "https://deno.land/std@0.200.0/fs/walk.ts";

const getFilesInDirectory = async (directory: string): Promise<string[]> => {
  const files = [];

  for await (const walkEntry of walk(directory)) {
    if (walkEntry.isFile) {
      if (walkEntry.path.includes("default.nix")) continue
      files.push(walkEntry.path)
    }
  }

  return files
}

const getImportsInFile = async (file: string): Promise<string[]> => {
  const text = await Deno.readTextFile(file);
  const lines = text.split("\n")
  const imports = [];

  for (let i = 0; i < lines.length; i++) {
    if (lines[i].includes("./")) {
      imports.push(file.split("./")[1].split("/")[0] + "/" + lines[i].split("./")[1].split(" ")[0])
    }
  }

  return imports
}

Deno.test("imports all modules in ./packages", async () => {
  const packageFiles = await getFilesInDirectory("./packages")
  const packageImports = await getImportsInFile("./packages/default.nix")

  console.log(packageFiles)
  console.log(packageImports)

  for (const file of packageFiles) {
    assert(packageImports.includes(file))
  }
})
