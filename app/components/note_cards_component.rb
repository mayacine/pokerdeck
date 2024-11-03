# frozen_string_literal: true

class NoteCardsComponent < ViewComponent::Base
  attr_reader :notes

  def initialize(notes:)
    @notes = notes
  end

  private

  def format_notes
    notes.map(&:to_s)
  end
end
