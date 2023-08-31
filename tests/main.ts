import { assertAllModulesInDirectory } from "./lib.ts";

const dirs = [
  "containers",
  "home",
  "modules",
  "overlays",
  "packages",
  "specializations",
];

for (const dir of dirs) {
  Deno.test(`imports all modules in ./${dir}`, async () => {
    await assertAllModulesInDirectory(dir);
  });
}
