local present, icons = pcall(require, "nvim-web-devicons")
if not present then
  return false
end

icons.setup({
  override = {
    c = {
      icon = "",
      color = "#4682B4",
      name = "c"
    }
  }
})