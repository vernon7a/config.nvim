local registry = require("mason-registry")
local path = require("mason-core.path")
local fn = require("mason-core.functional")
local fs = require("mason-core.fs")

return function()
  local installed_packages = registry.get_installed_packages()

  for _, pkg in pairs(installed_packages) do
    local receipt = pkg:get_receipt()
    local links = receipt._value.links["bin"]

    print("pkg-" .. pkg.name)

    for name, rel_path in pairs(links) do
      local link_abs_path = path.bin_prefix(name)
      local target_abs_path = path.concat({ pkg:get_install_path(), rel_path })

      fs.sync.write_file(
        link_abs_path,
        fn.dedent(([[
               @ECHO off
               GOTO start
               :find_dp0
                 SET dp0=%%~dp0
               EXIT /b
               :start
                 SETLOCAL
               CALL :find_dp0

               endLocal & goto #_undefined_# 2>NUL || title %%COMSPEC%% & "%s" %%*
           ]]):format(target_abs_path))
      )

      if fs.sync.file_exists(link_abs_path) and fs.sync.file_exists(target_abs_path) then
        print(" link: " .. link_abs_path .. " -> " .. target_abs_path)
      else
        print(" error: " .. link_abs_path .. " -> " .. target_abs_path)
      end
    end
  end
end
