const express = require('express')
const cors = require('cors')
const {PowerShell} = require('node-powershell')

const app = express()
const PORT = 3000

app.use(cors())

app.get('/', async (req, res) => {
	const ps = new PowerShell({
		debug: true,
		executableOptions: {
			'-ExecutionPolicy': 'Bypass',
			'-NoProfile': true,
		},
	})
	try {
		let scriptPath = require('path').resolve(process.cwd(), './script.ps1')
		const scriptCommand = PowerShell.command`. ${scriptPath}`
		const result = await ps.invoke(scriptCommand)
		const data = result.raw

		res.status(200).json({'message:': data})
	} catch (error) {
		console.log('🚀 ~ file: server.js:22 ~ app.get ~ error', error)
	} finally {
		await ps.dispose()
	}
})

app.listen(PORT, () => {
	console.log(`Server listening on port ${PORT}`)
})
