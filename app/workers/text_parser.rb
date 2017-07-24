class TextParser
  def org_adder(name)
    org = Organization.new
    org.name = name
    org.save
  end

  def doc_adder(org, name)
    doc = Document.new
    doc.name = name
    org.documents << doc
    doc.save
    puts doc
    doc
  end

  def chapter_adder(doc, chapter, index)
    chapter = chapter[1]
    ch = Chapter.new
    ch.name = chapter
    ch.number = index
    ch.unique_id = SecureRandom.uuid
    doc.chapters << ch
    ch.save
    ch
  end


  def section_adder(chapter, sections, subsections)
    sections.each do |section|
      sc = chapter.sections.new
      sc.name = section
      sc.order = section.match(/(\d{1,}.\d{1,})/)[1]
      sc.unique_id = SecureRandom.uuid
      sc.save
      subsection_adder(sc, subsections)
      sc
    end
  end

  def subsection_adder(section, subsections)
    subsections.each do |subsection|
      puts subsection
      sc = section.subsections.new
      sc.name = subsection
      sc.order = subsection.match(/(\d{1,}.\d{1,}.([a-z]|\d{1,}))/)
      sc.unique_id = SecureRandom.uuid
      sc.save
    end
  end

  def file_parser(doc)
    file = File.open('./app/workers/chapters.txt', 'rb')
    content = file.read.force_encoding('utf-8')
    paragraphs = content.split(/\n{3}/)
    index = 1
    paragraphs.each do |p|

      chapter = p.match(/chapter(.+)/)
      ch = chapter_adder(doc, chapter, index)
      strings = p.split(/\n{2}/)

      strings.each do |st|
        strings2 = st.split(/\n/)

        pp strings2
        sections = []
        subsections = []
        strings2.each do |st2|

          sections.push(st2.gsub('xsection', '')) if st2.include?('xsection')
          subsections.push(st2.gsub('subsection', '')) if st2.include?('subsection')
        end
        section_adder(ch, sections, subsections)
      end
      # pp chapter[0]
      # pp sections
      # pp subsections



      index = index + 1
      puts '------------------------'
    end

  end

  def image(index, doc)

  end

  def paragraph(subsection, paragraph)

  end

  def table(index, doc)
    doc.tables[index]
  end

  def run
    docu = doc_adder(Organization.first, 'Borrador')
    file_parser(docu)
    doc = Docx::Document.open('./app/workers/pmcm.docx')
    puts doc.tables.count
    puts ENV['SENDMAIL_USER']

# puts doc.tables[1].methods
# doc.tables[1].rows.each do |row| # Row-based iteration
#   row.cells.each do |cell|
#     # puts cell.text
#   end
# end
  end
end
t = TextParser.new
t.run