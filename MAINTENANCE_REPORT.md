# nvimz Maintenance Report
Date: 2026-09-03 21:10:32

## 1. Lockfile Validation
✅ Lockfile (`nvim-pack-lock.json`) is valid JSON.

## 2. Environment Health
```
────────────────────────────────────────────────────────────
 Core
────────────────────────────────────────────────────────────
 git                    OK         git version 2.55.0
 rg                     OK         ripgrep 15.2.0features:+pcre2simd(compile):+NEONsimd(runtime):+NEONPCRE2 10.45 is available (JIT is available)
 fd                     OK         fd 10.5.0
────────────────────────────────────────────────────────────
 LSP
────────────────────────────────────────────────────────────
 gopls                  MISSING    
 lua_ls                 OK         3.19.1
 rust_analyzer          OK         rust-analyzer 1
────────────────────────────────────────────────────────────
 Formatters
────────────────────────────────────────────────────────────
 stylua                 OK         stylua 2.5.2
 shfmt                  OK         (devel)
 prettier               MISSING    
 rustfmt                OK         rustfmt 1.9.0
────────────────────────────────────────────────────────────
 Linters
────────────────────────────────────────────────────────────
 golangci-lint          MISSING    
 cargo-clippy           OK         clippy 0.1.98
```

## 3. Startup Benchmark
Total startup time: **045.946ms** (Target: <20ms)

## 4. Parser Validation
```
--------------------------------------------------
 nvimz: Treesitter Parser Manager
--------------------------------------------------
✅ c: Already installed
✅ cpp: Already installed
✅ go: Already installed
✅ rust: Already installed
✅ python: Already installed
✅ typescript: Already installed
✅ tsx: Already installed
✅ lua: Already installed
✅ luadoc: Already installed
✅ vim: Already installed
✅ vimdoc: Already installed
✅ git_rebase: Already installed
✅ gitcommit: Already installed
✅ diff: Already installed
✅ markdown: Already installed
✅ markdown_inline: Already installed
✅ json: Already installed
✅ yaml: Already installed
✅ regex: Already installed
✅ scss: Already installed
✅ css: Already installed
✅ html: Already installed
✅ latex: Already installed
✅ bash: Already installed
✅ yuck: Already installed
✅ zsh: Already installed
--------------------------------------------------
```

