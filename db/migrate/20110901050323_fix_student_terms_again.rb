class FixStudentTermsAgain < ActiveRecord::Migration
  def self.up
    rename_column :students_terms, :students_id, :student_id
    rename_column :students_terms, :terms_id, :term_id
  end

  def self.down
  end
end
