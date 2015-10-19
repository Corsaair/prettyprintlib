ASDOC CUSTOM TEMPLATES
======================

While I was working on the Redtamarin documentation I needed more features 
and so I customised the asdoc templates.

Features:
- custom project logo
- custom documentation icons  
  for redtamarin
- custom link to a wiki  
  in the navigation bar
- custom link to an issue tracker  
  at bottom of a package
- custom code syntax coloring  
  with `prettify.js`


How to use the template
-----------------------

in your `build.xml`
```xml
<asdoc
    output="${basedir}/docs/${project.name}"
    templates-path="${basedir}/build/doc/templates/"
    main-title="${project.fullname}"
    footer="${project.name} v${project.version}"
    window-title="${project.fullname} v${project.version}"
    left-frameset-width="256"
    keep-xml="${build.fatswc}"
    skip-xsl="false"
    warnings="false"
    strict="false"
    failonerror="true"
    fork="true"
>
    <verbose-stacktraces>true</verbose-stacktraces>
    <load-config>${basedir}/build/flex-config.xml</load-config>

    <external-library-path dir="${basedir}/lib-swc" append="true">
        <include name="redtamarin.swc"/>
    </external-library-path>

    <doc-sources path-element="${basedir}/src/${project.name}.as"/>
    <package-description-file>${basedir}/build/doc/package.description.xml</package-description-file>
</asdoc>
```

you also need a `flex-config.xml`
```xml
<?xml version="1.0"?>
<flex-config>
   <compiler>
      <as3>true</as3>
      <es>false</es>
   </compiler>
</flex-config>
```

and a `package.description.xml`
```xml
<overviews>
	<all-packages>
		<description><![CDATA[
			The &lt;b&gt;Pretty Print&lt;/b&gt; library.&lt;br&gt;
			&lt;br&gt;
			
			Prettyprint (or pretty-print) is the application of any of various stylistic
			formatting conventions to text files, such as source code, markup, and similar
			kinds of content.&lt;br&gt;
			&lt;br&gt;
			These formatting conventions can adjust positioning and spacing (indent style),
			add color and contrast (syntax highlighting), adjust size, and make similar
			modifications intended to make the content easier for people to view, read,
			and understand.&lt;br&gt;
			&lt;br&gt;
			Prettyprinters for programming language source code are sometimes called
			code beautifiers or syntax highlighters.&lt;br&gt;
			&lt;br&gt;
			&lt;a href="https://github.com/Corsaair/prettyprintlib/wiki" target="_blank"&gt;Wiki Documentation&lt;/a&gt;
		]]></description>
	</all-packages>
	<packages>

		<package name="libraries.prettyprint" >
			<shortDescription><![CDATA[The prettyprint library.]]></shortDescription>
			<description><![CDATA[
				All interfaces, classes, etc. for pretty printing.
			]]></description>
		</package>
		
	</packages>
</overviews>
```



How to use in your AS3 source code
----------------------------------

To indicate a definition is for redtamarin, it will show a little monkey head.
```as3
    /**
     * Some text here.
     * 
     * @playerversion AVM 0.4
     * @langversion 3.0
     */

    /**
     * Some text here.
     * 
     * @playerversion Flash 9
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
```

To indicate a definition is for AIR, it will show a small AIR icon.
```as3
    /**
     * Some text here.
     * 
     * @playerversion AIR 3.0
     * @langversion 3.0
     */

    /**
     * Some text here.
     * 
     * @playerversion AIR 3.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
```

In this case no small icon is shown
```as3
    /**
     * Some text here.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */

    /**
     * Some text here.
     * 
     * @playerversion Flash 9
     * @langversion 3.0
     */
```


TODO

Here how to edit the templates for your own project.

1. Edit the logo
----------------

By default I use the as3lang.org logo in small
in `doc/templates/images/logo.jpg`.

To replace the logo you just need to replace that `logo.jpg`.

Use the PSD template `asdoc_logo.psd` to create your own :).


2. Edit title-bar.html
----------------------

Search the string `https://github.com/Corsaair/prettyprintlib/wiki`
and replace it with the URL of your project wiki page.

If you want to change the link name, also replace the string `wiki`.


3. Edit asdoc-util.xslt
-----------------------

Search the strings `https://github.com/Corsaair/prettyprintlib/issues`
and replace them with the URL of your project issue tracker page.
