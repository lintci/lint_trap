require_relative 'registerable'
require_relative 'parser/csslint'
require_relative 'parser/standard'
require_relative 'parser/vim_quickfix'

module LintTrap
  # Parser registry
  module Parser
    extend Registerable

    register CSSLint
    register Standard
    register VimQuickfix
    default Standard
  end
end
