<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" omit-xml-declaration="yes" indent="no" />
  <xsl:strip-space elements="*" />

  <xsl:template match="title">
    <xsl:value-of select="name"/>
  </xsl:template>

  <xsl:template match="map">
    Картата "<xsl:apply-templates select="title" />" е създадена
    на дата <xsl:value-of select="release" />
    <!--xsl:value-of select="//authors/author[@id=current()/author/@authorId]/title/name" /-->
    от <xsl:apply-templates select="//authors/author[@id=current()/author/@authorId]/title" />
    за играта
    <xsl:choose>
      <xsl:when test="game/@versionId">
        <xsl:apply-templates select="//versions/version[@id=current()/game/@versionId]/title" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="//games/game[@id=current()/game/@gameId]/title" />
      </xsl:otherwise>
    </xsl:choose>.

    Размерът ѝ е <xsl:value-of select="size/@x"/> на <xsl:value-of select="size/@y" />,
    а теренът е <xsl:value-of select="features/@tileset" />.

    Подходяща е за
    <xsl:choose>
      <xsl:when test="features/@maxPlayers = 1">
        един играч
      </xsl:when>
      <xsl:when test="features/@minPlayers = features/@maxPlayers">
        <xsl:value-of select="features/@minPlayers" /> играча
      </xsl:when>
      <xsl:otherwise>
        между <xsl:value-of select="features/@minPlayers" />
        и <xsl:value-of select="features/@maxPlayers" />
        играча
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="features/@teams">
      разделени в <xsl:value-of select="features/@teams" /> отбора
    </xsl:if>.

    <xsl:if test="features/@useMapSettings='true'">
      Картата има правила различни от стандартните.
    </xsl:if>
    <xsl:if test="features/@island='true'">
      Картата е островна.
    </xsl:if>
    <xsl:if test="features/@ladder='true'">
      Картата е била официална турнирна карта.
    </xsl:if>
  </xsl:template>

  <xsl:template match="authors" />

  <xsl:template match="games" />
</xsl:stylesheet>
