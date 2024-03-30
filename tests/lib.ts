import { assert } from "https://deno.land/std@0.200.0/assert/mod.ts";
import { walk } from "https://deno.land/std@0.200.0/fs/walk.ts";

/** Gets files in a given directory.
 *
 * @param directory The directory to get files from.
 * @returns An array of files in the given directory.
 */
async function getFilesInDirectory(directory: string): Promise<string[]> {
  const files = [];

  for await (const walkEntry of walk(directory)) {
    if (walkEntry.isFile) {
      if (walkEntry.path.includes("default.nix")) {
        continue;
      }

      files.push(walkEntry.path);
    }
  }

  return files;
}

/** Gets imports in a given nix file.
 *
 * @param file The file to search for nix imports.
 * @returns An array of imports in the given nix file.
 */
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

/** Assets that all files in a given directory are imported in default.nix.
 *
 * @param directory The directory to assert.
 * @param excludes Files to exclude from assertion. Useful for files imported elsewhere.
 */
export async function assertAllModulesInDirectory(
  directory: string,
  excludes?: string[],
) {
  const files = await getFilesInDirectory(`./${directory}`);
  const imports = await getImportsInFile(`./${directory}/default.nix`);

  for (const file of files) {
    const basename = file.split(`${directory}/`)[1];

    if (excludes && excludes.includes(basename)) {
      continue;
    }

    assert(imports.includes(file));
  }
}
