  dry_run = false

  tags = %x{git tag}.lines.map(&:strip).select { |line| line.length > 0 }.map do |version|
    clean_version = version
    if version == 'v1.3'
      clean_version = 'v1.3.0'
    end

    if version == 'v1.1'
      clean_version = 'v1.1.0'
    end

    tag = SemVer.parse(clean_version)
    raise "Unparsable tag #{version}" unless tag

    [version, tag]
  end

  new_tags = tags.map { |tag| [tag[0], tag[1].format(VERSION_FORMAT)] }

  new_tags.each do |new_tag|
    command = "git tag #{new_tag[1]} #{new_tag[0]}"

    if dry_run
      puts command
    else
      result = `#{command}`
      raise "Failed `#{command}` with error $?" unless $?.exitstatus == 0
    end

  end
