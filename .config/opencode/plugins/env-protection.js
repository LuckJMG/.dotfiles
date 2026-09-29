// V2 plugin. The default export is the plugin definition object itself, so
// this file needs no @opencode/plugin import and no npm install.
// The V2 read tool names its path argument "path".
export default {
  id: "env-protection",
  async setup(ctx) {
    await ctx.tool.hook("execute.before", (event) => {
      if (event.tool === "read" && event.input.path?.includes(".env")) {
        throw new Error("Do not read .env files")
      }
    })
  },
}
