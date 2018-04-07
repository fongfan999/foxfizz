module ModalsHelper
  DISMISS_CHARACTER = '&times;'.freeze
  DEFAULT_BTN_CLASSES = 'btn btn-bold btn-pure'.freeze

  # This method accepts either `:String` or `Object` that responds to `:to_key`
  # And it will generate modal id attribute on that.
  #
  # Example usage:
  # = modal(@user) do
  #   = modal_header 'Modal title'
  #   = modal_body do
  #     h1 Modal body
  #   = modal_footer
  def modal(id_or_obj)
    modal_id = id_or_obj.kind_of?(String) ? id_or_obj : dom_id(id_or_obj, :modal)

    content_tag(:div, id: modal_id, class: 'modal fade', tabindex: -1) do
      content_tag(:div, class: 'modal-dialog') do
        content_tag(:div, class: 'modal-content') { yield }
      end
    end
  end

  def modal_header(title)
    content_tag(:div, class: 'modal-header') do
      content_tag(:h5, title, class: 'modal-title') + modal_dismiss_button
    end
  end

  def modal_body
    content_tag(:div, class: 'modal-body') { yield }
  end

  def modal_footer(save_changes_text = I18n.t('save_changes'))
    content_tag(:div, class: 'modal-footer') do
      modal_cancel_button + modal_save_changes_button(save_changes_text)
    end
  end

  private

  def modal_dismiss_button
    content_tag(:button, class: 'close', type: 'button', data: { dismiss: 'modal' }) do
      content_tag(:span, DISMISS_CHARACTER.html_safe, aria: { hidden: true })
    end
  end

  def modal_cancel_button
    content_tag :button, t('cancel'), type: :button, data: { dismiss: 'modal' },
      class: "#{DEFAULT_BTN_CLASSES} btn-secondary"
  end

  def modal_save_changes_button(save_changes_text)
    content_tag :button, save_changes_text, type: :submit,
      class: "#{DEFAULT_BTN_CLASSES} btn-primary"
  end
end
