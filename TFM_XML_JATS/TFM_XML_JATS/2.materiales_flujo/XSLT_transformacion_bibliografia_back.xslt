<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ali="http://www.niso.org/schemas/ali/1.0/"
    xmlns:oasis="http://www.niso.org/standards/z39-96/ns/oasis-exchange/table"
    version="2.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <article article-type="research-article" dtd-version="1.3" xml:lang="{tei:TEI/tei:text/@xml:lang}">
            <xsl:attribute name="xsi:schemaLocation">
                <xsl:text>http://www.ncbi.nlm.nih.gov/JATS1 http://jats.nlm.nih.gov/publishing/1.3/JATS-journalpublishing-oasis-article1-3-mathml3.xsd</xsl:text>
            </xsl:attribute>
            
            <!-- Front matter -->
            <front>
                <journal-meta>
                    <journal-id journal-id-type="publisher-id">
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@level"/>
                    </journal-id>
                    <journal-title-group>
                        <journal-title>
                            <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                        </journal-title>
                    </journal-title-group>
                    <issn publication-format="electronic">
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:idno[@type='ISSN']"/>
                    </issn>
                    <publisher>
                        <publisher-name>
                            <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>
                        </publisher-name>
                    </publisher>
                </journal-meta>
                
                <article-meta>
                    <article-id pub-id-type="doi">
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:idno[@type='DOI']"/>
                    </article-id>
                    
                    <article-categories>
                        <subj-group subj-group-type="heading">
                            <subject>Artículos</subject>
                        </subj-group>
                    </article-categories>
                    
                    <title-group>
                        <article-title>
                            <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                        </article-title>
                    </title-group>
                    
                    <contrib-group>
                        <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author">
                            <contrib contrib-type="author">
                                <name>
                                    <surname><xsl:value-of select="tei:persName/tei:surname"/></surname>
                                    <given-names><xsl:value-of select="tei:persName/tei:forename"/></given-names>
                                </name>
                                <xsl:if test="tei:affiliation">
                                    <xref ref-type="aff" rid="aff-{position()}"/>
                                </xsl:if>
                            </contrib>
                        </xsl:for-each>
                    </contrib-group>
                    
                    <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author[tei:affiliation]">
                        <aff id="aff-{position()}">
                            <institution>
                                <xsl:value-of select="tei:affiliation/tei:orgName"/>
                            </institution>
                        </aff>
                    </xsl:for-each>
                    
                    <pub-date date-type="pub" publication-format="electronic">
                        <xsl:variable name="date" select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:appInfo/tei:application/@when"/>
                        <year><xsl:value-of select="substring($date, 1, 4)"/></year>
                        <month><xsl:value-of select="substring($date, 6, 2)"/></month>
                        <day><xsl:value-of select="substring($date, 9, 2)"/></day>
                    </pub-date>
                    
                    <permissions>
                        <copyright-statement>
                            <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/tei:licence"/>
                        </copyright-statement>
                    </permissions>
                    
                    <abstract>
                        <p>
                            <xsl:value-of select="tei:TEI/tei:teiHeader/tei:profileDesc/tei:abstract/tei:div/tei:p"/>
                        </p>
                    </abstract>
                    
                    <kwd-group kwd-group-type="author-keywords">
                        <xsl:for-each select="tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords/tei:term">
                            <kwd><xsl:value-of select="."/></kwd>
                        </xsl:for-each>
                    </kwd-group>
                </article-meta>
            </front>
            
            <!-- Body content -->
            <body>
                <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div"/>
            </body>
            
            <!-- Back matter (references) -->
            <back>
                <ref-list>
                    <xsl:for-each select="tei:TEI/tei:text/tei:back/tei:div[@type='references']/tei:listBibl/tei:biblStruct">
                        <ref id="bib{position()}">
                            <element-citation publication-type="journal">
                                <person-group person-group-type="author">
                                    <name>
                                        <surname><xsl:value-of select="tei:monogr/tei:author/tei:persName/tei:surname"/></surname>
                                        <given-names><xsl:value-of select="tei:monogr/tei:author/tei:persName/tei:forename"/></given-names>
                                    </name>
                                </person-group>
                                <article-title><xsl:value-of select="tei:monogr/tei:title"/></article-title>
                                <source><xsl:value-of select="tei:monogr/tei:title"/></source>
                                <year><xsl:value-of select="tei:monogr/tei:imprint/tei:date"/></year>
                                <xsl:if test="tei:idno[@type='DOI']">
                                    <pub-id pub-id-type="doi"><xsl:value-of select="tei:idno[@type='DOI']"/></pub-id>
                                </xsl:if>
                            </element-citation>
                        </ref>
                    </xsl:for-each>
                </ref-list>
            </back>
        </article>
    </xsl:template>
    
    <!-- Section headings -->
    <xsl:template match="tei:div[tei:head]">
        <sec>
            <xsl:if test="tei:head/@n">
                <xsl:attribute name="id">
                    <xsl:text>sec</xsl:text>
                    <xsl:value-of select="translate(tei:head/@n, '.', '')"/>
                </xsl:attribute>
            </xsl:if>
            <title>
                <xsl:value-of select="tei:head"/>
            </title>
            <xsl:apply-templates select="*[not(self::tei:head)]"/>
        </sec>
    </xsl:template>
    
    <!-- Paragraphs -->
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Figures -->
    <xsl:template match="tei:figure">
        <fig id="{@xml:id}">
            <caption>
                <p>
                    <xsl:value-of select="tei:figDesc"/>
                </p>
            </caption>
            <graphic xlink:href="{tei:graphic/@url}"/>
        </fig>
    </xsl:template>
    
    <!-- Tables -->
    <xsl:template match="tei:table">
        <table-wrap>
            <table>
                <xsl:copy-of select="*"/>
            </table>
        </table-wrap>
    </xsl:template>
    
    <!-- References in text -->
    <xsl:template match="tei:ref[@type='bibr']">
        <xref ref-type="bibr" rid="bib{count(preceding::tei:biblStruct) + 1}">
            <xsl:apply-templates/>
        </xref>
    </xsl:template>
    
    <!-- Footnotes -->
    <xsl:template match="tei:note[@place='foot']">
        <xref ref-type="fn" rid="fn{@n}">
            <sup><xsl:value-of select="@n"/></sup>
        </xref>
    </xsl:template>
    
    <!-- Preserve text nodes -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>