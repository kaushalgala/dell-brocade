require 'puppet/type/brocade_messages'

Puppet::Type.newtype(:brocade_zone_membership) do
  @doc = "This represents a Addition and removal of Member to/from existing zone on brocade switch."

  apply_to_device

  ensurable

  newparam(:name, :namevar => true) do
    desc "This parameter is tuple of alias name and member perameter"

    munge do |value|
      @resource[:zonename], @resource[:member] = value.split(':',2)
      value
    end
  end

  newparam(:zonename) do
    desc "This parameter describes the zone name to be created on the Brocade switch."
    validate do |value|
      Puppet::Type::Brocade_messages. empty_value_check(value, Puppet::Type::Brocade_messages::ZONE_NAME_BLANK_ERROR)
      Puppet::Type::Brocade_messages.special_char_check(value, Puppet::Type::Brocade_messages::ZONE_NAME_SPECIAL_CHAR_ERROR)
      Puppet::Type::Brocade_messages.numeric_char_check(value, Puppet::Type::Brocade_messages::ZONE_NAME_NUMERIC_CHAR_ERROR)
    end
  end

  newparam(:member) do
    desc "This parameter describes the member node to be added in the zone"
    validate do |value|
      Puppet::Type::Brocade_messages.empty_value_check(value, Puppet::Type::Brocade_messages::ZONE_MEMBER_BLANK_ERROR)
      Puppet::Type::Brocade_messages.member_value_format_check(value)
      Puppet::Type::Brocade_messages.numeric_char_check(value, Puppet::Type::Brocade_messages::MEMBER_NAME_NUMERIC_CHAR_ERROR)
    end
  end

end

