class Help < Command
  verb :help, :h
  help_text %{Get help on the commands you can use.\nEg:\n  "help" displays a list of all the commands.\n  "help wait" describes the "wait" command.}

  def run(world, action)
    _, *tail = (action || [])
    msg = ''
    if tail.length > 0
      command = Command.find(tail)
      msg = "Command help: #{command_desc command}\n#{command.help}"
    else
      msg = list_commands
    end
    return world, [SideEffect::Message.new(msg)]
  end

  private

  def list_commands
    msg = "You can...\n"
    Command.descendants.sort_by do |c| c.verbs.first.to_s end.each do |c|
      msg += "  #{command_desc c}\n"
    end
    msg += %{For more info, type for example "help inven" to learn more about the "inventory" command.}
    msg
  end

  def command_desc(c)
    extra = ''
    if c.verbs.length > 1
      _, *remain = c.verbs
      extra = " (#{remain.join(', ')})"
    end
    "#{c.verbs.first}#{extra}"
  end
end
