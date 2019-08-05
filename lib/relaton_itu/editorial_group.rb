module RelatonItu
  class EditorialGroup
    BUREAUS = %w[T D R].freeze

    # @return [String]
    attr_reader :bureau

    # @returnn [RelatonItu::ItuGroup]
    attr_reader :group

    # @return [RelatonItu::ItuGroup, NilClass]
    attr_reader :subgroup, :workgroup

    # @param bureau [String]
    # @param group [Hash, RelatonItu::ItuGroup]
    # @param subgroup [Hash, RelatonItu::ItuGroup, NilClass]
    # @param workgroup [Hash, RelatonItu::ItuGroup, NilClass]
    def initialize(bureau:, group:, subgroup: nil, workgroup: nil)
      raise ArgumentError, "invalid bureau: #{bureau}" unless BUREAUS.include? bureau

      @bureau = bureau
      @group = group.is_a?(Hash) ? ItuGroup.new(group) : group
      @subgroup = subgroup.is_a?(Hash) ? ItuGroup.new(subgroup) : subgroup
      @workgroup = workgroup.is_a?(Hash) ? ItuGroup.new(workgroup) : workgroup
    end

    # @param builder [Nokogiri::XML::Builder]
    def to_xml(builder)
      builder.editorialgroup do
        builder.bureau bureau
        builder.group { |b| group.to_xml b }
        builder.subgroup { |b| group.to_xml b } if subgroup
        builder.workgroup { |b| group.to_xml b } if workgroup
      end
    end
  end
end