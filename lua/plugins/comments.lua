return {
  {
    "numToStr/Comment.nvim",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          enable_autocmd = false,
        },
      },
    },
    config = function()
      local ok, comment = pcall(require, "Comment")
      if not ok then
        return
      end

      local ok_ctx, ctx = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      local pre_hook = nil
      if ok_ctx then
        local hook = ctx.create_pre_hook()
        pre_hook = function(hctx)
          local commentstring = hook(hctx)
          if commentstring == nil or commentstring == "" then
            return vim.bo.commentstring
          end
          return commentstring
        end
      end

      comment.setup({
        pre_hook = pre_hook,
      })
    end,
  },
}
