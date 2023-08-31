import { assert } from "https://deno.land/std@0.200.0/assert/mod.ts";
import { walk } from "https://deno.land/std@0.200.0/fs/walk.ts";

async function getFilesInDirectory(directory: string): Promise<string[]> {
  const files = [];

  for await (const walkEntry of walk(directory)) {
    if (walkEntry.isFile) {
      if (walkEntry.path.includes("default.nix")) continue;
      files.push(walkEntry.path);
    }
  }

  return files;
}

async function getImportsInFile(file: string): Promise<string[]> {
  const text = await Deno.readTextFile(file);
  const lines = text.split("\n");
  const imports = [];

  for (let i = 0; i < lines.length; i++) {
    if (lines[i].includes("./")) {
      imports.push(
        file.split("./")[1].split("/")[0] + "/" +
          lines[i].split("./")[1].split(" ")[0],
      );
    }
  }

  return imports;
}

export async function assertAllModulesInDirectory(directory: string) {
  const files = await getFilesInDirectory(`./${directory}`);
  const imports = await getImportsInFile(`./${directory}/default.nix`);

  for (const file of files) {
    assert(imports.includes(file));
  }
}
