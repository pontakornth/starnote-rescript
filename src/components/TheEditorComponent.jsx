import {Prism as SyntaxHighlighter} from 'react-syntax-highlighter'
import {vscDarkPlus as dark} from 'react-syntax-highlighter/dist/esm/styles/prism'

export const components = {
	code({node, inline, className, children, ...props}) {
	const match = /language-(\w+)/.exec(className || '')
		return !inline && match ? (
		<SyntaxHighlighter style={dark} language={match[1]} PreTag="div" children={String(children).replace(/\n$/, '')} {...props} />
		) : (
		<code className={className} {...props}>
			{children}
		</code>
		)
	}
}
