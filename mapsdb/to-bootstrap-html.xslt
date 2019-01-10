<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="mapdb">
    <link rel="stylesheet" href="bootstrap-cyborg.min.css"></link>
    <style>
      .modal img {
        max-width: 100%;
      }

      .map {
        padding-bottom: 60px;
      }
    </style>
    <div class="container">
      <xsl:apply-templates select="@* | node()"/>
    </div>
  </xsl:template>

  <xsl:template match="title">
    <div class="text-center">
      <xsl:choose>
        <xsl:when test="logo">
          <img>
            <xsl:attribute name="src">
              <xsl:value-of select="logo"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
              <xsl:value-of select="name"/>
            </xsl:attribute>
          </img>
        </xsl:when>
        <xsl:otherwise>
          <h1><xsl:value-of select="name"/></h1>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="downloads">
    <xsl:for-each select="full">
      <div>
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="text()" />
          </xsl:attribute>

          <xsl:choose>
            <xsl:when test="@name">
              <xsl:value-of select="@name" />
            </xsl:when>
            <xsl:otherwise>
              Download <xsl:value-of select="../../title/name" />
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
    </xsl:for-each>

    <xsl:for-each select="demo">
      <div>
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="text()" />
          </xsl:attribute>

          <xsl:choose>
            <xsl:when test="@name">
              <xsl:value-of select="@name" />
            </xsl:when>
            <xsl:otherwise>
              Download <xsl:value-of select="../../title/name" /> demo
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
    </xsl:for-each>

    <xsl:for-each select="patch">
      <div>
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="text()" />
          </xsl:attribute>

          <xsl:choose>
            <xsl:when test="@name">
              <xsl:value-of select="@name" />
            </xsl:when>
            <xsl:otherwise>
              Download <xsl:value-of select="../../title/name" /> patch
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="map">
    <div class="map">
      <xsl:apply-templates select="title" />

      <div class="text-center">
        <xsl:if test="preview">
          <a href="#" data-toggle="modal">
            <xsl:attribute name="data-target">#modal-<xsl:value-of select="generate-id(preview)" /></xsl:attribute>
            Map Preview
          </a>

          <div class="modal fade" tabindex="-1" role="dialog">
            <xsl:attribute name="aria-labelledby">modal-label-<xsl:value-of select="generate-id(preview)" /></xsl:attribute>
            <xsl:attribute name="id">modal-<xsl:value-of select="generate-id(preview)" /></xsl:attribute>
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&#215;</span>
                  </button>
                  <h4 class="modal-title" id="myModalLabel">Map Preview</h4>
                </div>
                <div class="modal-body">
                  <img alt="Map Preview">
                    <xsl:attribute name="src">
                      <xsl:value-of select="preview" />
                    </xsl:attribute>
                  </img>
                </div>
              </div>
            </div>
          </div>
        </xsl:if>
        <xsl:apply-templates select="downloads" />
      </div>

      <div class="row">
        <div class="col-sm-offset-1 col-md-offset-2 col-sm-6 col-md-5">
          <xsl:value-of select="title/description" />
        </div>
        <ul class="col-sm-4 col-md-3">
          <li>
            Size: <xsl:value-of select="size/@x"/>&#xd7;<xsl:value-of select="size/@y" />
          </li>
          <li>
            Tileset: <xsl:value-of select="features/@tileset" />
          </li>
          <li>
            Players:
            <xsl:choose>
              <xsl:when test="features/@minPlayers = features/@maxPlayers">
                <xsl:value-of select="features/@minPlayers" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="features/@minPlayers" />
                -
                <xsl:value-of select="features/@maxPlayers" />
              </xsl:otherwise>
            </xsl:choose>
          </li>
          <xsl:if test="features/@teams">
            <li>
              Teams: <xsl:value-of select="features/@teams" />
            </li>
          </xsl:if>
          <xsl:if test="features/@useMapSettings='true'">
            <li>
              Use map settings
            </li>
          </xsl:if>
          <xsl:if test="features/@island='true'">
            <li>
              Island map
            </li>
          </xsl:if>
          <xsl:if test="features/@ladder='true'">
            <li>
              Official Ladder Map
            </li>
          </xsl:if>
          <li>
            Game:
            <xsl:choose>
              <xsl:when test="game/@versionId">
                <a href="#" data-toggle="modal">
                  <xsl:attribute name="data-target">#modal-<xsl:value-of select="game/@versionId" /></xsl:attribute>
                  <xsl:value-of select="//versions/version[@id=current()/game/@versionId]/title/name" />
                </a>
              </xsl:when>
              <xsl:otherwise>
                <a href="#" data-toggle="modal">
                  <xsl:attribute name="data-target">#modal-<xsl:value-of select="author/@gameId" /></xsl:attribute>
                  <xsl:value-of select="//games/game[@id=current()/game/@gameId]/title/name" />
                </a>
              </xsl:otherwise>
            </xsl:choose>
          </li>
          <li>
            Author:
            <a href="#" data-toggle="modal">
              <xsl:attribute name="data-target">#modal-<xsl:value-of select="author/@authorId" /></xsl:attribute>
              <xsl:value-of select="//authors/author[@id=current()/author/@authorId]/title/name" />
            </a>
          </li>
          <xsl:if test="release">
            <li>
              Release date: <xsl:value-of select="release" />
            </li>
          </xsl:if>
        </ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="authors">
    <xsl:apply-templates select="author" />
  </xsl:template>

  <xsl:template match="author">
    <div class="modal fade" tabindex="-1" role="dialog">
      <xsl:attribute name="aria-labelledby">modal-label-<xsl:value-of select="@id" /></xsl:attribute>
      <xsl:attribute name="id">modal-<xsl:value-of select="@id" /></xsl:attribute>
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&#215;</span>
            </button>
            <h4 class="modal-title">
              <xsl:attribute name="id">modal-label-<xsl:value-of select="@id" /></xsl:attribute>
              Author: <xsl:value-of select="title/name" />
            </h4>
          </div>
          <div class="modal-body">
            <xsl:if test="title/logo">
              <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="title/logo"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="title/name"/>
                </xsl:attribute>
              </img>
            </xsl:if>
            <div>
              <a target="_blank">
                <xsl:attribute name="href">
                  <xsl:value-of select="url"/>
                </xsl:attribute>
                Official site
              </a>
            </div>
            <xsl:if test="email">
              <div>
                <a>
                  <xsl:attribute name="href">
                    mailto:<xsl:value-of select="email"/>
                  </xsl:attribute>
                  Send mail
                </a>
              </div>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="games">
    <xsl:apply-templates select="game" />
  </xsl:template>

  <xsl:template match="game">
    <div class="modal fade" tabindex="-1" role="dialog">
      <xsl:attribute name="aria-labelledby">modal-label-<xsl:value-of select="@id" /></xsl:attribute>
      <xsl:attribute name="id">modal-<xsl:value-of select="@id" /></xsl:attribute>
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&#215;</span>
            </button>
            <h4 class="modal-title">
              <xsl:attribute name="id">modal-label-<xsl:value-of select="@id" /></xsl:attribute>
              Game: <xsl:value-of select="title/name" />
            </h4>
          </div>
          <div class="modal-body">
            <xsl:if test="title/logo">
              <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="title/logo"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="title/name"/>
                </xsl:attribute>
              </img>
            </xsl:if>
            <xsl:if test="url">
              <div>
                <a target="_blank">
                  <xsl:attribute name="href">
                    <xsl:value-of select="url"/>
                  </xsl:attribute>
                  Official site
                </a>
              </div>
            </xsl:if>
            <xsl:apply-templates select="downloads" />
          </div>
        </div>
      </div>
    </div>

    <xsl:apply-templates select="versions" />
  </xsl:template>

  <xsl:template match="versions">
    <xsl:apply-templates select="version" />
  </xsl:template>

  <xsl:template match="version">
    <div class="modal fade" tabindex="-1" role="dialog">
      <xsl:attribute name="aria-labelledby">modal-label-<xsl:value-of select="@id" /></xsl:attribute>
      <xsl:attribute name="id">modal-<xsl:value-of select="@id" />
      </xsl:attribute>
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&#215;</span>
            </button>
            <h4 class="modal-title">
              <xsl:attribute name="id">modal-label-<xsl:value-of select="@id" /></xsl:attribute>
              Game: <xsl:value-of select="title/name" />
            </h4>
          </div>
          <div class="modal-body">
            <xsl:if test="title/logo">
              <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="title/logo"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="title/name"/>
                </xsl:attribute>
              </img>
            </xsl:if>
            <xsl:if test="../../url">
              <div>
                <a target="_blank">
                  <xsl:attribute name="href">
                    <xsl:value-of select="../../url"/>
                  </xsl:attribute>
                  Official site
                </a>
              </div>
            </xsl:if>
            <xsl:apply-templates select="downloads" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
