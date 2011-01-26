<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.1"
    >
    <!-- $Id:$ -->

    <xsl:attribute-set name="paragraph-block">
        <xsl:attribute name="space-after">12pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="literal-block">
        <xsl:attribute name="font-family">monospace</xsl:attribute>
        <xsl:attribute name="font-size">8</xsl:attribute>
        <xsl:attribute name="white-space">pre</xsl:attribute>
    </xsl:attribute-set>


    <xsl:attribute-set name="transition-block">
        <xsl:attribute name="space-before">12pt</xsl:attribute>
        <xsl:attribute name="space-after">12pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="document-title-block">
        <xsl:attribute name="space-after">12pt</xsl:attribute>
        <xsl:attribute name="font-size">24pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="document-title-page-block">
        <xsl:attribute name="break-after">page</xsl:attribute>
        
    </xsl:attribute-set>

    <xsl:attribute-set name="document-subtitle-block">
        <xsl:attribute name="space-before">12pt</xsl:attribute>
        <xsl:attribute name="space-after">12pt</xsl:attribute>
        <xsl:attribute name="font-size">18pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="block-quote-outer-block">
        <xsl:attribute name="start-indent">20mm</xsl:attribute>
        <xsl:attribute name="end-indent">20mm</xsl:attribute>
        <xsl:attribute name="space-after">12pt</xsl:attribute>
        <xsl:attribute name="space-before">12pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="block-quote-paragraph-block">
        <xsl:attribute name="start-indent">inherit</xsl:attribute>
        <xsl:attribute name="end-indent">inherit</xsl:attribute>
        <xsl:attribute name="space-before">12pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="block-quote-first-paragraph-block" use-attribute-sets="block-quote-paragraph-block">
        <xsl:attribute name="space-before">0pt</xsl:attribute>
    </xsl:attribute-set>


    <xsl:attribute-set name="block-quote-attribution-block">
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>

    <!--default paragraphs-->
    <xsl:template match="section/paragraph|document/paragraph">
        <fo:block role="paragraph" xsl:use-attribute-sets="paragraph-block">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="literal_block">
        <fo:block xsl:use-attribute-sets="literal-block" role="literal-block"><xsl:apply-templates/></fo:block>
    </xsl:template>

    <xsl:template match="transition">
        <fo:block xsl:use-attribute-sets = "transition-block" role="transition">
            <!--
            <fo:inline><fo:leader leader-pattern="rule" leader-length="3in"/></fo:inline>
            -->
            <xsl:value-of select="$transition-text"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="document/subtitle">
        <xsl:if test="$page-sequence-type = 'body' or $page-sequence-type='toc-body'">
            <fo:block xsl:use-attribute-sets="document-subtitle-block" role="subtitle">
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="document/title">
        <xsl:if test="$page-sequence-type = 'body' or $page-sequence-type = 'toc-body'">
            <fo:block xsl:use-attribute-sets="document-title-block" role="title">
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if> 
    </xsl:template>

    <xsl:template match="document/title" mode="front">
        <fo:block xsl:use-attribute-sets="document-title-page-block" role="title-page">
            <fo:block xsl:use-attribute-sets="document-title-block" role="title">
                <xsl:apply-templates/>
            </fo:block>
            <xsl:apply-templates select="/document/subtitle" mode="front"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="document/subtitle" mode="front">
        <fo:block xsl:use-attribute-sets="document-subtitle-block" role="subtitle">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="block_quote">
        <fo:block role="block-quote" xsl:use-attribute-sets = "block-quote-outer-block">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="block_quote/paragraph">
        <fo:block role="block-quote" xsl:use-attribute-sets = "block-quote-paragraph-block">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="block_quote/paragraph[1]" priority="2">
        <fo:block role="block-quote" xsl:use-attribute-sets = "block-quote-first-paragraph-block">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="block_quote/attribution">
        <fo:block role="block-quote" xsl:use-attribute-sets = "block-quote-attribution-block">
            <xsl:value-of select="$text-before-block-quote-attribution"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="comment"/>
    
</xsl:stylesheet>