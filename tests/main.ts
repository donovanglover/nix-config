import { assertAllModulesInDirectory } from "./lib.ts";

/** A list of directories to check for all Nix modules being imported */
const dirs = [
  "containers",
  "home",
  "modules",
  "overlays",
  "packages",
  "specializations",
];

/** A helper function to return excluded files.
 *
 * @param directory The directory to get excludes for.
 * @returns An array of excluded files for the given directory or undefined.
 */
function getExcludes(directory: string): string[] | undefined {
  switch (directory) {
    case "packages":
      return ["hycov.nix"];
  }
}

for (const dir of dirs) {
  Deno.test(`imports all modules in ./${dir}`, async () => {
    await assertAllModulesInDirectory(dir, getExcludes(dir));
  });
}
