# Witness for Claude Code

AI coding agents present every change with the same confidence, but some
parts they tested and some they guessed. Witness records what Claude
actually checked while it works (the tests and builds that ran after each
edit and what they covered, the files it read) and what it assumed. On every
pull request it tells reviewers where to look: "Review 3 of 4 sections
closely, skim the rest", with the reason for each.

This plugin connects Claude Code to Witness. It needs the `witness` command
line tool, which is installed separately and works in git repositories that
have been set up with `witness init`. See the
[Witness README](https://github.com/radical-studios/witness#readme) for
installing it and setting up a repository.

## What the plugin adds

- **Hooks** that pass each Claude Code event (tool calls, prompts, the end
  of a turn, session start and end) to `witness hook`, which records it in
  the repository. They run `hooks/witness.sh`, which calls the `witness`
  binary on your `PATH`, in `~/.local/bin` or in `~/.cargo/bin`. If the
  binary isn't installed the hooks do nothing, and in a Witness repository
  the session start shows a note saying how to install it. Hooks never
  block Claude Code.
- **A skill** that asks Claude to run the tests covering its edits, record
  unverified assumptions with `witness assume`, and check `witness status`
  before saying it's done.
- **Two commands**: `/witness:status` summarizes what is failing, guessed or
  unchecked on the branch, and `/witness:review` reviews the branch using
  Witness's review plan.

## What it runs, stores and sends

The plugin itself downloads nothing and makes no network requests. The
`witness` binary writes session logs under `.witness/` in your repository,
to be committed with your code. They hold paths, line ranges, line hashes,
tool names, redacted command text, exit codes, test counts and the
assumptions Claude states, and never file contents, tool output, prompts,
Claude's messages or environment variables. Nothing is sent anywhere except
the report you choose to post on a pull request, usually from CI. See
[PRIVACY.md](https://github.com/radical-studios/witness/blob/main/docs/PRIVACY.md).

The hooks and commands are for Claude Code. In claude.ai chat only the skill
loads, and it applies only to repositories that use Witness.

## License

Apache-2.0
